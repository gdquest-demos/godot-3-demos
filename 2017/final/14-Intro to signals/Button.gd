extends Button

# Creating a new, custom signal. We can now use it with the connect() method and emit it anytime
signal test
signal test_with_arguments


func _ready():
	# We retrieve the sprite node to connect to
	var SpriteNode = get_node("/root/Game/Sprite")
	# Self is optional in this call. It's only here for the sake of clarity
	# We're connecting the node the script is attached to (self) to the Sprite node
	# PARAMETERS:
	# 1. The name of the signal ("pressed")
	# 2. The node to send the signal to (the Sprite node)
	# 3. The name of the method to call on the receiver (change_color())
	# 4. An array of arguments to bind to the receiver. They will be mapped to the parameters of 
	# the called method, e.g. change_color(name) requires 1 argument, the name of the color to use
	self.connect("pressed", SpriteNode, "change_color", [get_name()])

	# Emitting the signal is as simple as passing the signal's name. 
	# It doesn't matter if another node receives the signal or not.
	# Signals are emitted all the time. When you press a button, its "pressed" signal is sent out
	# But if nothing is connected to the button, it's lost.
	emit_signal("test")
	# You can optionally send an array of arguments. 
	# Careful though: if you bind arguments with self.connect(), you'll get an error
	# Only send arguments with emit_signal if they change between calls
	emit_signal("test_with_arguments", [get_name(), get_pos()])
