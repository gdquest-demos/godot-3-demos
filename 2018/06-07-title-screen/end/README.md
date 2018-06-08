# Tutorial Outline

### Intro

*Present myself to begin with*

- This is a _hands on_ tutorial on how to create a Title Screen for a game
- By the end, we'll have a complete menu with a transition effect that supports both _Mouse_ and _Keyboard_ inputs.
- If you'd like to follow along, there's a link for the project with all the assets on the description of the video.

### Preparation
- Change the Window's width and height to 1280px x 720px
- Set the Default Clear Color of the Environment to _#263138_

### Title Screen Scene
- Create a new Scene, add a Control node and define it's Layout to be a Full Rect
	- Rename it to TitleScreen
	- This is the base of our Menu, which is going to hold all other control nodes
- Add MarginContainer as a child to the TitleScreen
	- Custom Constants:
		- Right/Left: 120 px
		- Top/bottom: 80px
- Add a VBoxContainer as a child of our MarginContainer
	- Add a TextureRect as a child
		- Drag and drop the _logo.png_ from the Assets panel to the TextureRect's Texture property
		- Rename the TextRect to Logo
	- Add a HBoxContainer as a child of the MarginContainer
		- This node is responsible for separating our menu's options from our characters image
		- Size Flags > Vertical > Fill and Expand
			- This stretches the HBoxContainer vertically to cover all the remaining space left on the Y axis of it's parent's Rect.
		- Add a VBoxContainer as a child of the HBoxContainer.
			- This Node will hold the Options of our Menu
			- Size Flags > Fill and Expand on both Horizontal and Vertical. We want this Node's rect to cover half of it's parent's Rect once we add the Characters image.
			- Custom Constants > Separation > 30 - This will keep a 30px margin between each child of this node.
			- Add one Label as a Child and rename it to Continue. 
			- Use the Montserrat-ExtraBold.tff to create and add a new custom font of size 48
			- Set the Label's Text property to "Continue" and check Uppercase on the inspector
			- Add a shadow of color _#ff9700_ with an offset of 5px on Y and 0 on X
			- Size Flags > Expand Horizontally - We want the rect to cover only what's needed instead of taking the whole parent's width
			- Duplicate the node twice and change the Text for New Game and Options
			- *ADD THE FOOTER*
		- Add a CenterContainer as a Child of the HBoxContainer
			- Size Flags > Fill and Expand for both Horizontal and Vertical. Now this node is covering half of the HBoxContainer's Width while the VBoxContainer is doing the same, but on the left side.
			- Add a TextureRect as a child of the CenterContainer and rename it to Characters
			- Drag the _characters.png_ from the AssetPanel to the Characters' Texture property
