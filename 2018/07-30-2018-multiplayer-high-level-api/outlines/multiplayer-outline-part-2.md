# Multiplayer Part 2

*Outline's Pitch: Overview of the Player Scene: how to use slaves and masters and letting clients simulate behaviors instead of syncing everything through network*

_Disclaimer:_ This is the continuation of this series' first video. If you haven't watched it already, please do before watching this one. 

## Intro
 - Now that our players can create and connect to servers, they need an actual game to play
 - For this demo, we'll take a look at a 2D shooting deathmatch game
 - Even though the game is small, with it we'll be able to see how to spawn and respawn players and different approaches to sync data.


## Create the first player
- The first created player, either on the server or clients, if the player itself. 
	+ That's because we use the same scene for the player himself and for the other connected players - in other words, the other peers of the network that you're connected to.
- This happens on the `_ready()` function of our Game script, which is attached to the Game scene. 
- The player scene gets preloaded and instantiated.
	+ This node's name is set to the peer's unique id. 
		* In Godot every node in the game tree needs to have an unique name. As the variable's name suggests, the peer has an unique id and by setting the node's name to it, we don't run into any problems. 
		* Another advantage of doing so, is in the case we need to access this peer's player scene from a different location. By having the peer ID we can get it's node easily by checking the name.
	+  Then, the Player Scene network master is set to ourselves by using the `set_network_master()` function and passing our unique ID to it.
		* The network master of a node is the peer that has authority over it. 
		* As soon as we get to the Player's code we'll get to see where this comes into play.
	+ Finally, the `init()`function is called on the newly created player, receiving three parameters:
		* The first one being this Player's nickname
		* The second one is the initial position of the node
		* The third one if used to determinate if this is either a Slave player or a Master one. In this case, it's a master, so we pass false to it, meaning it's **not** a slave.

## The Player Code

- The two constants are used to define how fast the player moves and it's maximum health.
- An `enum` is used to know in which direction the player should move on each frame. As it is, the player can either not move or move to one of four directions: up, down, left, and right.
- We also have two variables that have the `slave` keyword before them. 
	+ This means that these variables we'll have their values set by the **master** of this scene
	+ In this case, we have a Vector2() which is used to sync the **master's position** with the **slave** and also an `enum` of type `MoveDirection` that's used to simulate the movement of the **slave** based on the **master's inputs** - aka the player himself.
 - And then there's the `health_points` variable that holds the player's current HP. This variable is initialized with the same value as the MAX_HP `const`.
 - Inside the `_ready()`function `_update_health_bar()` gets called to correctly set the player's health bar's value.
 - Now, in `_physics_process()`we check for inputs and move the players accordingly. 
	 + The `direction`variable is used to know in which direction the player has to move in this given frame. It's initialized with the value of `NONE`in case no input is given by the player. 
	 + A check is made to determine if this is the master. If it is, we'll check for inputs.
		 * Depending on the pressed action, the previously created `direction`variable receives a value accordingly.
	+ `_move()` is called, receiving the correct direction and moves the player. We'll soon see how this function works.
	+ After moving the player, rset() is called.
		* This network specific function remotely sets the value of a variable. In this case, we're setting the `slave_movement` variable to equal to the master's `direction`. 
		* The same is true for `rset_unreliable()`. The difference between them is the fact that, with the second one, the engine does not guarantee that the information will indeed get to all peers. In fact, it might not reach any of them. The benefit of using it is performance.
		* In this case, there's no problem as  `slave_position`is only used to sync the slaves' positions to their master's and this is done on every frame. If the information is not received, the peer will most likely receive it on the next frame and update itself correctly.
		* It's also important to note that every function that does a remote procedure, for instance, rpc, rpc_id, etc. has an equivalent _unreliable one.
	+  But, if this is not the master, we pass `slave_movement` to `_move ` and set the slave's position to be equal to the master's.
	+ Finally, if this is the server, we save this scene's current position in the case of another peer connecting to the network. This way, the slaves get created at an updated position on the newly connected peer. 
- `_move()` matches the received direction to determine in which direction it's going to move the Player. In the case that the movement goes to the right or to the left, `_rifle_right()` and `_rifle_left()` gets called accordingly, making the rifle face the same direction as the player.
- The `_update_health_bar()` function passes the player's current health points to the HealthBar node so it can show it on the bar correctly.
- The `damage()` function is used by other scripts to damage the player. In this game, it's called by our Bullet once it hits the player. It subtracts the current health points by the received value, checks if the player died, and updates the health bar. 
	+ In the case that the player dies, it does an RPC which is going to call a function named `_die()`
- `_die()` has the `sync` keyword before it. This means that when an RPC is done, this function will also be called on the peer that's doing the RPC.
	+ The function starts a timer
	+ Stops the physics process of both the Player and Rifle
	+ Hides all of the Node's children that can be hidden
	+ And by the end, disables the collision of the Player so it won't get shot while respawning. 
- When the `RespawnTimer` timesout, it pretty much does the opposite of what _die() did: restarts the physics processes, enables collision once again and sets the Player's HP to it's maximum.
- Finally, we have the `init()` function, which is used when the Player scene gets instantiated. 
	+  After passing the correct name to be displayed to the GUI, the function updates the starting position of the Player and in the case of this being a salve, sets a different texture to the Sprite node of the player.
		 * This gives us a nice effect where the player will always see his character with the original blue color and all other players with the color green. 
