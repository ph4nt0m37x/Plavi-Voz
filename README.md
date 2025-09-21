#  Plavi Voz

Plavi Voz is a mini 3D story-driven game built in Godot with survival elements. You play as Viktor, a survivor in a sudden winter apocalypse in 1970s Yugoslavia.
The game begins with Viktor searching for shelter to survive the night, but his ultimate goal is to reach Belgrade and find his wife, who was visiting her mother when the disaster struck.
The story combines survival mechanics with narrative choices, culminating in Viktor trying to reach the train that promises salvation for the few remaining survivors.

Link to the video demo since it was too big for github: https://drive.google.com/file/d/1WNV2Ksl9n6w8_4nlcQptG7ZLNKpAJZuy/view?usp=drive_link

## Movement

The player can move using the W, A, S, and D keys to move in all directions, use Space to jump, and Shift to sprint.
The game features dynamic footsteps, which change depending on the player’s speed and interaction with the snow-covered terrain, enhancing immersion in the winter environment.

## Dialogue

To handle the monologues, we used Dialogue Manager, a plugin available in the Godot Asset Library.
It allowed us to store dialogue lines in external files, manage branching conversations, and implement different choices and consequences for the player’s actions.


## Radio Repairing

The radio repair sequence is a choice-based interactive segment where the player must make decisions.
At each stage, the player is presented with multiple options, but only the correct choice advances the sequence.
If the player makes a mistake, helpful hints are provided, and they are allowed to retry until they get it right.
Successfully choosing all three correct choices results in the radio being repaired, allowing the story to progress.

## Flashlight Mechanic

The player’s mechanical flashlight is an essential tool for exploring dark areas and finding hidden clues.
To generate power, the flashlight must be manually cranked by pressing R, but it needs to be turned off while doing so.
Once charged, the flashlight can be toggled on and off with F, allowing the player to conserve power when it is not needed.
Using the flashlight wisely is key, as it gradually consumes energy while turned on.

## Exploring the map

The player can equip the map by pressing M, bringing up a hand-held map that displays the surrounding terrain, landmarks, and key locations such as the train tracks, shelters, or dangerous zones.
While viewing the map, the player can study the environment, decide which routes to take, and plan where to avoid hazards like radiation, hostile creatures, or blocked paths.
Landmarks and clues help the player orient themselveves.


## Exploration rewards
Throughout the game, players can discover small, optional story moments that are not required to progress.
This includes things like old photographs lying around, restricted daedly areas, or little environmental details that add depth and flavor to the world.
Interacting with these optional elements gives extra context to the environment and disaster that occured, enriching the story.


## Ambiance

For the ambiance, we have implemented moving clouds and a night cycle with a moon using Sky3D to give the sky a realistic feel.
The terrain was created with Terrain3D, letting us make mountains, frozen rivers, and textured landscapes.
We also used Godot’s weather system for snow and atmospheric effects, and added wind sounds to make the environment more immersive and engaging.


## Preview

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/edc7a7f1-4d29-426f-a0b2-6dd9267d3188" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/24ea4034-4c51-464a-8bdc-ca2a0e2358b2" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/20149da5-0c42-4164-bf7a-b8221ff6c762" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3a455d1f-2472-41ef-b22b-f35765a8dd16" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/1deab57a-12e0-4568-b02d-d3d92cb1ca81" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/3c00cb71-6890-411b-a2ca-be1e2e2ffbc5" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/8c60a67d-cd71-40cf-8320-c37f1219d924" />

## Inspiration

Our game was heavily inspired by The Long Dark, as a winter survival game. We wanted to capture the feel of Yugoslavia through the lens of our parents, who lived during that period, and aimed to evoke not only the aesthetics of that era, but also the tension and intrigue surrounding the disaster itself, with a sense of mystery that hints at the hidden stories and unanswered questions of the politics of that era.
We also drew inspiration from authentic family photos from Yugoslavia from one of our families.
Marko modeled an authentic Yugoslavian radio, and we found a vintage manual online to accurately replicate how it functions.
While we really wanted to create a fully realized world, time constraints meant we could not expand the game as much as we had hoped.
Nevertheless, this project represents a glimpse of the vision we would love to continue exploring in our free time.

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
- Bag Asset
  - https://www.cgtrader.com/free-3d-models/various/various-models/bag-asset-f4888c7f-9ace-46e3-b30c-59efa8ccf696
- Radio Tower Asset
  - https://www.cgtrader.com/free-3d-models/exterior/historic-exterior/bandeirantes-tower

### Textures

- TextureCan
  - https://www.texturecan.com/
- ambientCG
  - https://ambientcg.com/
- Sound
    - https://pixabay.com/
- Shaders
    - https://godotshaders.com/shader/screen-space-frost-with-volumetric-snow/


