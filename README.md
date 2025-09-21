#  Plavi Voz

Plavi Voz is a mini 3D story-driven game built in Godot with survival elements. You play as Viktor, a survivor in a sudden winter apocalypse in 1970s Yugoslavia.
The game begins with Viktor searching for shelter to survive the night, but his ultimate goal is to reach Belgrade and find his wife, who was visiting her mother when the disaster struck.
The story combines survival mechanics with narrative choices, culminating in Viktor trying to reach the train that promises salvation for the few remaining survivors.

---

## Movement

The player can move using the W, A, S, and D keys to move in all directions, use Space to jump, and Shift to sprint.
The game features dynamic footsteps, which change depending on the player’s speed and interaction with the snow-covered terrain, enhancing immersion in the winter environment.

## Flashlight Mechanic

The player’s mechanical flashlight is an essential tool for exploring dark areas and finding hidden clues.
To generate power, the flashlight must be manually cranked by pressing R, but it needs to be turned off while doing so.
Once charged, the flashlight can be toggled on and off with F, allowing the player to conserve power when it is not needed.
Using the flashlight wisely is key, as it gradually consumes energy while turned on.

## Dialogue

To handle the monologues, we used Dialogue Manager, a plugin available in the Godot Asset Library.
It allowed us to store dialogue lines in external files, manage branching conversations, and implement different choices and consequences for the player’s actions.


## Radio Repairing

The radio repair sequence is a choice-based interactive segment where the player must make decisions.
At each stage, the player is presented with multiple options, but only the correct choice advances the sequence.
If the player makes a mistake, helpful hints are provided, and they are allowed to retry until they get it right.
Successfully choosing all three correct choices results in the radio being repaired, allowing the story to progress.

## Second minigame

## Exploration rewards
Throughout the game, players can discover small, optional story moments that are not required to progress. This includes things like old photographs lying around, interesting objects, or little environmental details that add depth and flavor to the world.
Interacting with these optional elements gives extra context to the environment and disaster that occured, enriching the story.


## Ambiance

For the ambiance, we have implemented moving clouds and a night cycle with a moon using Sky3D to give the sky a realistic feel.
The terrain was created with Terrain3D, letting us make mountains, frozen rivers, and textured landscapes.
We also used Godot’s weather system for snow and atmospheric effects, and added wind sounds to make the environment more immersive and engaging.


## Preview




## Credits

### Plugins

- Terrain3D
    - https://github.com/TokisanGames/Terrain3D
- Sky3D
    - https://github.com/TokisanGames/Sky3D
- GodotWeatherSystem
    - https://github.com/mlavik1/GodotWeatherSystem
- Dialogue Manager
    - https://godotengine.org/asset-library/asset/3654
- Tree Assets
    - https://www.cgtrader.com/free-3d-models/plant/other/winter-tree-2
    - https://www.cgtrader.com/free-3d-models/plant/other/winter-tree-3
- Medkit Asset
  - https://www.cgtrader.com/free-3d-models/science/medical/medical-kit-cc83280c-3b98-4410-9f17-cc5930fac1bd
- Car Asset
  - https://www.cgtrader.com/free-3d-models/car/suv/uaz-3d
- Wolf Asset
  - https://www.cgtrader.com/free-3d-models/animals/mammal/wolf-king-8a9a9e58-ea52-4928-b435-bd21bce75e9d
- Road Signs Assets
  - https://www.cgtrader.com/free-3d-models/animals/mammal/wolf-king-8a9a9e58-ea52-4928-b435-bd21bce75e9d

### Textures

- TextureCan
  - https://www.texturecan.com/
- ambientCG
  - https://ambientcg.com/
- Sound
    - https://pixabay.com/
- Shaders
    - https://godotshaders.com/shader/screen-space-frost-with-volumetric-snow/
