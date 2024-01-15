# SchiffeVersenken
## Battleship, Sea Battle or in German "Schiffe versenken"

References:
-[1] https://opengameart.org/content/sea-warfare-set-ships-and-more
-[2] https://docs.godotengine.org/de/4.x/tutorials/networking/high_level_multiplayer.html
-[3] https://opengameart.org/content/radar-parts
-[4] https://en.wikipedia.org/wiki/Battleship_(game)

## Introduction
While looking for some interesting sprites and tilesets I found by chance the ships [1] that reminded me of a paper game we used to play in school: "Schiffe versenken" (in German) or "Battleship" [4] as it seems to be called in English.
It's a two player game where you draw two 10x10 grids, one for your own ships (hidden from the other player) and one for your enemy. Every player places their ships either horizontally or vertically on the grid, diagonals are not allowed. The ships have different sizes: 1 field for the smallest vessel, 5 fields for the largest one: the battleship. 
In every turn the players call the field where the want to shoot at, like "B7" and their enemy checks if a ship was hit and calls out either "hit" or "miss". A ship is removed from the game when all of its fields have been hit. The player who shoots first all the ships of their enemy wins the game.

So as I had all the necessary sprites and the game loop is also known, it seemed not to be too difficult to implement the game in Godot. Furthermore, I wanted to go a step further and do this as my first network multiplayer game [2] in this game engine.

## Currently implemented
This is currently a work in progress, but this it what I currently have:
- Main menu with audio and video options.
- Single player: player can add their ships on the grid.
- Multiplayer: lobby prepared. Server implementation following [2].
- Separate audio busses for music and sound effects.
- OOP: a ship class. Individual ships inherit from this class.
- Enemy grid: in single player mode, the enemy is controlled by the computer. [TODO: all ships need to be added]
- Game loop: counts current round, radar animation [3], game time is shown.

## Open issues/ToDos
Everything seems to be prepared, so things need to be finalized. TODO:
- Complete computer enemy. Currently only carrier and battleship are placed on the grid. Checking valid grid positions: ships are not allowed to overlap: there must always be at least one empty field between ships. Not all angles (0°, 90°, 180°, 270°) are currently working correctly. 
- Complete game loop logic. Firing not yet implemented.
- Signals on multiplayer lobby. LAN to be implemented first. If that is tested and working, Bluetooth might also follow (maybe not).
- Implementation of special rules (aircraft for carrier, two shots per round for battleship, rescue ship cannot fire, but repair another ship...).
- More music and sound effects.


Start of programming: 02-Jan-2024
