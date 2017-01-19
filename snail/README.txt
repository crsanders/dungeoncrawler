Dungeon Crawler was developed by Christian Sanders as an attempt to learn Ruby.
As such, it is highly likely to be inefficiently coded and may not fully
conform to the Ruby Style Guide.  Future revisions will attempt to fix these
issues.


Required to run Dungeon Crawler:
Ruby 1.9.x
JSON Ruby Gem

To start Dungeon Crawler:
ruby dungeon_crawler_ver_snail.rb

All commands must be typed in lower case

The goal of the game is to get as far down in the dungeon as possible.  Along
the way you will encounter monsters and discover loot.  Your character will
gain levels by defeating monsters and advancing through the dungeon.

Full list of commands:

advance - Moves to the next room/floor if the current room does not contain monsters
ad - Same as advance
attack - Attacks an enemy.  Will prompt for a target if there are multiple enemies.  Fails if there are no monsters in the room
at - Same as attack
loot - Gathers the loot in the room.  Fails if there is no loot in the room
status - Prompts the user if they want to view player or room status
player status - Displays your character's status
room status - Displays the status of the current room, including room number, floor number, number of monsters, and number of loot
health - Displays your character's health
attack status - Displays your character's attack
defense status - Displays your character's defense
save - Saves your character data, the current floor layout, the current room number, and the current floor number
help - Displays the help menu

The following commands are not intended for player use, but are listed here for documentation purposes
debug - Displays the monster data in the current room.  If there are no monsters returns an empty array.
inventory - Displays the player's inventory.  Future revisions will have a use for this.
bag - Same as inventory
