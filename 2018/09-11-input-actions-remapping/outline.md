# Input Remapping Outline

### Introduction
 - Present myself
 - Creation of a controls menu will be covered
 - Players will be able to selected from
	 - Two predefined profiles
	 - Cutomize his own profile to suit his gameplay style
 - We'll see the results in a small demo
 

 **Game Overview**
 - Starts in the demo scene
 - Player can move around and test controls
 - Press esc to go to the controls menu
 - There's a list containing:
	 - The actions
	 - The control that's binded to it
	 - Button to change the control
		 - Only available if custom profile selected
 - Press play to go back to the demo scene and test the new controls
 
**Demo Scene**
_Just a quick overview since this isn't the focus of this tutorial - should take less than 15 seconds to show_
- Contains 4 boundaries and a KinematicBody2D player 
- _Open the player script_
- The script listens to pressed events on the actions and moves the player accordingly

**InputMenu Scene**
- Whole scene is made of control nodes
	- Besides the InputMapper - responsible to map the inputs
- The Column holds all the nodes responsible to display the list of inputs
- ProfilesMenu is a an OptionButton used to select the profile
	- Options are set by code
- All the possible inputs of the profile are held by the ActionList
	- The lines are set by code
- KeySelectMenu is a hidden panel
	- It's displayed when an input action is being remapped
	- _Turn it on and off_

**InputMenu Script**
- Gets a reference to the ActionList
	- Will be used to build the list later on
- Ready function
	- Connects the rebuild function to InputMapper's profile_changed signal
	- Initialize the ProfilesMenu
	- Changes the the current selected one
		- This triggers profile_changed, which calls rebuild
- Rebuild function
	- input_profile and is_customizable is passed to rebuild by the signal
		- The first is a dictionary with keys as the action name and values as the actual input
	- All lines are removed from action list with clear
	- New lines are used using add_input_line
	- In case this profile is customizable, it's change_button_pressed signal is connected to  _on_InputLine_change_button_pressed
- InputLine change 
	- The input process it stoped and the overlay gets shown
	- The functions is yielded and waits for the return of the key_selected function from the KeySelectMenu
		- _Should I mention that you're working on a tutorial that will go in detail about yields?_
	- With the new input received, the line is updated to display the new value
	- Process input is resumed
- The last two functions are used to switch to the demo scene

**Input Mapper Script**
- current_profile_id holds the current selected profile id from the profiles dictionary
	- Each value of this dictionary represents another dictionary that holds the information of an input profile
- The keys of the profiles are the same, what changes are the values
	- On profile_normal the movement is done using the arrows
	- profile_alternate uses WASD
	- The custom profile is used by the player to customize his experience and is initialized with the same values as the normal profile
- change_profile receives the id of the new selected profile
	- The new profile is retrieved from the profiles using the id
	- is_customizable is set to true if the profile id is 2
		- Which is the id of the custom profile
	- change_action_key is called for each action in the profile 
	- profile_changed signal is emitted and the new profile is returned by the function
- _change_action_key first removes all the current events in this action
	- When the profile is changed we don't want the action to have two events, i.e. up key and W key for move_up
	- A new event is created using the InputEventKey class
		- The event's scancode is set to the passed scancode
	- action_add_event is called on InputMap to add the new event to the desired action
	- The selected profile is updated
- erase_action events receives the action that should have it's events erased
	- The array of events is retrieved from the action using InputMap.get_action_list
	- For each event, action_erase_event is called to remove it from the action

**Recap**
- Keep in mind that we're changing pre created actions' inputs _open Input Map_
- There are a few other scripts in this project
	- Won't go in detail, they're pretty much all UI
	- You can take a look at them on github
