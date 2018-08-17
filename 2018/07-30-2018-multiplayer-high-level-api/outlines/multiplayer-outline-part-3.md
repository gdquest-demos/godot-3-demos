# Multiplayer Part 3

*Outline's Pitch: Using simulation on multiplayer games: spawning bullets and updating the GUI.*



## Intro

 - On part 2 we spawned players
 - We need them to shoot each other now
 - Also, the GUI needs to be updated
 - Might sound complex, but the code is pretty similar to a single player game
 
## The Rifle - Script and Scene
 - Preloads bullet scene
 - _process
	 + Verifies if it's the network master
		 * Only the "owner" peer shall be able to shoot
	+ Timer used to define interval between shots
	+ A RPC is used to spawn the bullet
		* `sync` used to spawn in all peers
		* `flip_h` used to determine the bullet's direction
- The scene is composed by a `Sprite `, and a `Timer`, responsible for the interval between shots

## The Bullet - Script and Scene

- `SPEED` and `DAMAGE` used to configure the Bullet
- `direction` used to define whether to fly to the left or right
- On `_ready()`, `set_as_top_level()` is called
	+ This way, the Bullet doesn't inherits the Rifle's `Transform ` which would cause it to move with the Rifle, causing a non desired effect.
- The Bullet is an Area2D
	+ `_on_body_entered()`  connected to identify hits
		* Checks if the body is not the player himself
		* Checks if the body isn't a player
		* Finally, damages the Player and gets removed from the tree
- `VisibilityNotifier2D ` responsible for removing the Bullet from the game once it leaves the screen
- This Scene's script does _not_ use any network related functions.
	+ Code would be the same for a single player game - except the group check on body entered
	+ You don't need to reinvent the wheel
		* The bullet will be spawned on all peers and behave the same
		* For this reason, there's no need to sync it's position across peers as we did with the Player
		* You could use this type of approach to create a turn based/tower defense game, for instance


## GUI Scene
- Scene is composed by:
	+ A `Control` node as the root
	+ `TextureProgress` node for the health bar
		* Anchored to top center of the root
	+ `Label` node for the nickname
		* Anchored to bottom center of the root
- No script is attached to this scene as it's controlled by the Player 

## Conclusion
- This whole part of the game relies on simulation
	+ We know that these scenes will work the same on all peers
	+ Code is less complex and saves networking resources

