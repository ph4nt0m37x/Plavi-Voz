extends CharacterBody3D
@export var MOVE_SPEED: float = 50.0
@export var JUMP_SPEED: float = 2.0
@export var headbob_freq := 2
@export var headbob_amp := .04
var headbob_time := 0.0
var foot_sound := true
var foot_land := true

# Light shake variables
@export var light_shake_enabled: bool = true
@export var light_shake_intensity: float = 0.15  # Much stronger than headbob
@export var light_shake_freq: float = 3.0  # Different frequency from headbob
var light_shake_time := 0.0
var light_original_pos: Vector3
var spotlight_node: SpotLight3D

# Flashlight power system variables
var flashlight_enabled: bool = true
@export var flashlight_power: float = 100.0  # Full power (0-100)
@export var power_drain_rate: float = 100.0 / 30.0  # Drains fully in 30 seconds
var is_blinking: bool = false
var blink_timer: float = 0.0
@export var blink_interval: float = 0.4  # Base blinking interval

# Recharge variables
var is_recharging: bool = false
@export var recharge_rate_multiplier: float = 2.0  # Recharge at double the drain rate

# Charging audio tracking
var is_charging_audio_playing: bool = false

var can_move: bool = true # to make the character not move during dialogue

@export var first_person: bool = false : 
	set(p_value):
		first_person = p_value
		if first_person:
			var tween: Tween = create_tween()
			tween.tween_property($CameraManager/Arm, "spring_length", 0.0, .33)
			tween.tween_callback($Body.set_visible.bind(false))
		else:
			$Body.visible = true
			create_tween().tween_property($CameraManager/Arm, "spring_length", 6.0, .33)

@export var gravity_enabled: bool = true :
	set(p_value):
		gravity_enabled = p_value
		if not gravity_enabled:
			velocity.y = 0
			
@export var collision_enabled: bool = true :
	set(p_value):
		collision_enabled = p_value
		$CollisionShapeBody.disabled = ! collision_enabled
		$CollisionShapeRay.disabled = ! collision_enabled

func _ready():
	# Find the SpotLight3D node - adjust the path to match your scene structure
	spotlight_node = get_node_or_null("%SpotLight3D")  # Using unique name
	if not spotlight_node:
		spotlight_node = get_node_or_null("SpotLight3D")  # Direct child
	if not spotlight_node:
		spotlight_node = get_node_or_null("CameraManager/SpotLight3D")  # Under camera
	
	if spotlight_node:
		light_original_pos = spotlight_node.position
		# Ensure flashlight is initially enabled
		flashlight_enabled = spotlight_node.visible

func _physics_process(p_delta) -> void:
	if not can_move:
		return
		
	var direction: Vector3 = get_camera_relative_input()
	var h_veloc: Vector2 = Vector2(direction.x, direction.z).normalized() * MOVE_SPEED
	if Input.is_key_pressed(KEY_SHIFT):
		h_veloc *= 2
	velocity.x = h_veloc.x
	velocity.z = h_veloc.y
	if gravity_enabled:
		velocity.y -= 40 * p_delta
	move_and_slide()
	
	# Camera headbob
	headbob_time += p_delta * velocity.length() * float(is_on_floor())
	%Arm.transform.origin = headbob(headbob_time)
	
	# Update flashlight power
	update_flashlight_power(p_delta)
	
	# Independent light shake (only if flashlight is enabled, not blinking off, and moving)
	var is_moving = velocity.length() > 0.1
	if light_shake_enabled and spotlight_node and flashlight_enabled and (not is_blinking or spotlight_node.visible) and is_moving:
		light_shake_time += p_delta * light_shake_freq
		spotlight_node.position = light_original_pos + light_shake()
	elif spotlight_node:
		spotlight_node.position = light_original_pos
	
	# Foot landing audio
	if not foot_land and is_on_floor(): # Landed
		%FootAudio3D.play()
	elif foot_land and not is_on_floor(): # Jumped 
		%FootAudio3D.play()
	foot_land = is_on_floor()

# Update flashlight power and handle blinking
func update_flashlight_power(delta: float):
	# Only drain power if flashlight is on and we're not recharging
	if flashlight_enabled and spotlight_node and not is_recharging:
		# Drain power when flashlight is on
		flashlight_power = max(0, flashlight_power - power_drain_rate * delta)
		
		# Stop charging audio if it's playing
		if is_charging_audio_playing:
			%ChargingAudio3D.stop()
			is_charging_audio_playing = false
		
		# Handle blinking based on power level
		if flashlight_power <= 50.0 and flashlight_power > 0:
			is_blinking = true
			handle_blinking(delta)
		elif flashlight_power <= 0:
			# Flashlight is completely dead
			spotlight_node.visible = false
			is_blinking = false
		else:
			# Normal operation
			spotlight_node.visible = true
			is_blinking = false
	elif not flashlight_enabled and spotlight_node and is_recharging:
		flashlight_power = min(100.0, flashlight_power + power_drain_rate * recharge_rate_multiplier * delta)
		
		# Play charging audio if not already playing
		if not is_charging_audio_playing:
			%ChargingAudio3D.play()
			is_charging_audio_playing = true
	else:
		# Stop charging audio if it's playing
		if is_charging_audio_playing:
			%ChargingAudio3D.stop()
			is_charging_audio_playing = false

# Handle the blinking behavior
func handle_blinking(delta: float):
	blink_timer += delta
	
	# Calculate blink frequency based on power level
	# Lower power = faster blinking (shorter interval)
	var current_interval = blink_interval * (flashlight_power / 50.0)
	
	if blink_timer >= current_interval:
		blink_timer = 0
		
		# Calculate on chance based on power level
		# Lower power = less chance to stay on
		var on_chance = flashlight_power / 50.0
		
		# Add some randomness
		var random_factor = randf()
		
		if random_factor < 0.8:  # 80% chance for normal blink
			spotlight_node.visible = randf() < on_chance
		elif random_factor < 0.9:  # 10% chance for double blink
			spotlight_node.visible = false
			create_tween().tween_callback(func(): 
				if is_blinking: spotlight_node.visible = randf() < on_chance
			).set_delay(current_interval * 0.3)
		else:  # 10% chance for long blink
			spotlight_node.visible = false
			create_tween().tween_callback(func(): 
				if is_blinking: spotlight_node.visible = randf() < on_chance
			).set_delay(current_interval * 0.7)

# Camera headbob function (unchanged)
func headbob(headbob_time):
	var headbob_pos = Vector3.ZERO
	
	headbob_pos.y = sin(headbob_time * headbob_freq) * headbob_amp
	headbob_pos.x = cos(headbob_time * headbob_freq / 2) * headbob_amp
	
	var foot_tresh = -headbob_amp + .002
	if headbob_pos.y > foot_tresh:
		foot_sound = true
	elif headbob_pos.y < foot_tresh and foot_sound:
		foot_sound = false
		%FootAudio3D.play()
	
	return headbob_pos

# Independent light shake function
func light_shake() -> Vector3:
	var shake_pos = Vector3.ZERO
	
	# Different patterns for more chaotic shake
	shake_pos.x = sin(light_shake_time * 1.3) * light_shake_intensity
	shake_pos.y = cos(light_shake_time * 1.7) * light_shake_intensity * 0.8
	shake_pos.z = sin(light_shake_time * 2.1) * light_shake_intensity * 0.6
	
	return shake_pos

# Start/stop light shake functions
func start_light_shake():
	light_shake_enabled = true

func stop_light_shake():
	light_shake_enabled = false

# Toggle flashlight function
func toggle_flashlight():
	if spotlight_node:
		flashlight_enabled = !flashlight_enabled
		
		# Apply state to the actual spotlight
		spotlight_node.visible = flashlight_enabled
		# (or spotlight_node.light_enabled = flashlight_enabled if using a Light3D)

		# If turning on and power was depleted, give it a small boost
		if flashlight_enabled and flashlight_power <= 0:
			flashlight_power = 5.0
		
		print("Flashlight: ", "ON" if flashlight_enabled else "OFF")
		print("Power: ", int(flashlight_power), "%")
		
# Returns the input vector relative to the camera. Forward is always the direction the camera is facing
func get_camera_relative_input() -> Vector3:
	var input_dir: Vector3 = Vector3.ZERO
	if Input.is_key_pressed(KEY_A): # Left
		input_dir -= %Arm.global_transform.basis.x
	if Input.is_key_pressed(KEY_D): # Right
		input_dir += %Arm.global_transform.basis.x
	if Input.is_key_pressed(KEY_W): # Forward
		input_dir -= %Arm.global_transform.basis.z
	if Input.is_key_pressed(KEY_S): # Backward
		input_dir += %Arm.global_transform.basis.z
	if Input.is_key_pressed(KEY_E) or Input.is_key_pressed(KEY_SPACE): # Up
		velocity.y += JUMP_SPEED + MOVE_SPEED * .016
	if Input.is_key_pressed(KEY_Q): # Down
		velocity.y -= JUMP_SPEED + MOVE_SPEED * .016
	if Input.is_key_pressed(KEY_KP_ADD) or Input.is_key_pressed(KEY_EQUAL):
		MOVE_SPEED = clamp(MOVE_SPEED + .5, 5, 9999)
	if Input.is_key_pressed(KEY_KP_SUBTRACT) or Input.is_key_pressed(KEY_MINUS):
		MOVE_SPEED = clamp(MOVE_SPEED - .5, 5, 9999)
	return input_dir

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseButton and p_event.pressed:
		if p_event.button_index == MOUSE_BUTTON_WHEEL_UP:
			MOVE_SPEED = clamp(MOVE_SPEED + 5, 5, 9999)
		elif p_event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			MOVE_SPEED = clamp(MOVE_SPEED - 5, 5, 9999)
	
	elif p_event is InputEventKey:
		if p_event.pressed:
			if p_event.keycode == KEY_V:
				first_person = ! first_person
			elif p_event.keycode == KEY_G:
				gravity_enabled = ! gravity_enabled
			elif p_event.keycode == KEY_C:
				collision_enabled = ! collision_enabled
			elif p_event.keycode == KEY_L:  # Toggle light shake with L key
				light_shake_enabled = ! light_shake_enabled
			elif p_event.keycode == KEY_F:  # Toggle flashlight with F key
				toggle_flashlight()
			elif p_event.keycode == KEY_R:  # Start recharging with R key
				is_recharging = true
				print("Started recharging")
		elif not p_event.pressed:
			if p_event.keycode == KEY_R:  # Stop recharging when R is released
				is_recharging = false
				# Stop charging audio
				if is_charging_audio_playing:
					%ChargingAudio3D.stop()
					is_charging_audio_playing = false
				print("Stopped recharging. Power: ", int(flashlight_power), "%")
		# Handle key releases for movement
		if not p_event.pressed and p_event.keycode in [KEY_Q, KEY_E, KEY_SPACE]:
			velocity.y = 0
