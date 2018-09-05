# Lobby, Server and Player Connection

_This is the first video of the series_

_Outline's Pitch: Introduction to Godot 3's High Level Multiplayer API. Overview of the code to create a simple Lobby, how to create the server and client, and how to connect a player to the server._

_Should we mention that this is an intermediate topic?_

## Video Intro

 - Godot offers a High Level Networking API to help bring players together in multiplayer games
 - The engine takes care of the most technical aspects of networking and allows us to focus on the gameplay
 - This is the first video in the series. We are going to see how to create a simple multiplayer game starting with the lobby. You are going to learn how to create a server and connect players together
 - This is just an intro series. Networking is complex and there is a lot to learn on the subject. I'm here to get you started with Godot's tools. If you want to dive deeper, you'll find links to great resources in the description below

## Create a simple Lobby
 - A lobby can be used to let players start the game at the same time
 - In this case, the lobby is used to let the player create or connect to the server, which can be done at any time
 - Before doing so, the player must type his nickname as it's going to be used during the gameplay phase
 - This step isn't required and is only used here to show how you can save players' informations.
 -- You could, for instance, save the type of weapon the player decided to use during gameplay.
 - If we click on either join or connect, a function is called on an autloaded _(is there a video that explain this? point the viewer to it?)_ script called Netowrk from our Menu script
## Creating the server
 - To begin with, we'll see how the server gets created as this is the first step needed to let other players connect to our game
 - The script has three constants used to configure the server
 -- The default IP is set to localhost, in a _real world scenario_ you'd let the player type this. For example, if I wanted to let you connect to my server, I would give you my external IP with the port used to create the server so you could connect to it.
 -- The port defines which port to use when creating and connecting to the server. Depending on the ports that are being used on your machine this can be changed.
 -- Max players define what is the maximun number of players that can connect to the server
 - The funtion called from the Menu when we click on create is the create_server
 -- We pass a parameter to it which is the player's nickname and we save this on our self_data object
 -- Then, this object gets added to the players array. This array will be used later when we connect other players to the game
 -- A new peer is created using the NetworkedMultiplayerENet class. This object is used to create the server using the pre defined port and max number of players.
 -- Finally this object is provided to the tree of our game, which initializes the High Level Networking.
 - That's it! We now have a server running on our machine and the current scene is switched to the Game scene.
 
## Connect a player to the Server

- To connect to the server the process is more complex
-- Since we already have at least one player (the server itself) playing the game, we must create the correct scenes on the newly connected player as well as create the new player on all other players.
-- This is something that has to be taken in consideration while developing a multiplayer game. You have to make sure that all the players are synced, which, in simple words, means that they are all seeing the same thing in this particular game.
- The connect_to_server function also receives the player's nickname as a parameter which is then set on the self_data object
-- We then connect to the connected_to_server signal. This signal is emitted as soon as this peer connects to the server.
-- After this is done, a peer is created and instead of calling create_server, create_client is called and the IP is passed, in this case, the localhost, and the the port. Remember that you'd have to provide the server's external IP to connect to a game over the internet.
 -- Once again, the High level networking is initialized by providing the created peer to the game tree.
 - If everything works as expected, the _connect_to_server function is called. 
 -- Every connected peer has an unique ID. The server is always the id 1 and every other peer gets an ID which is grater than one once it connects to the server. 
-- This ID is used to set the index of the object on the players array and it's information
 -- Then a RPC is called using the rpc() function

## Calling RPCs
 
 - RPC stands for Remote Procedure Call. In other words, this function will be called from this peer on all other peers that have the same function.
 - The first argument of the rpc function is the name of the function that we wanna call, in this case it's _send_player_info.
 -- This is the only required parameter, the following ones are only necessary if the RPC itself (_send_player_info) receives parameters. 
 -- _send_player_info expects two parameters, the first one being the unique id of the peer that is doing the RPC and the second being it's information.
 - You'll notice that this function has the remote keyword before the func keyword. The remote keyword is used to tell the engine that this function can be called via RPC's.
 -- Besides remote, there's also sync. The only difference is that functions with remote before them won't be called on the peer that did the RPC and functions that have sync before them will.
 - At first, the function checks if this peer is the server. Because, remeber, this function gets called on every peer of the network.
 -- This being true, rpc_id gets called to create a RPC on the new player, using his unique id, to pass the information of the already connected players.
 -- If not, a new instance of the Player scene is created and it's name is set to the unique id of the player.
