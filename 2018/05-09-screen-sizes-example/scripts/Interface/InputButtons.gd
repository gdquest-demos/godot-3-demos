extends Container

signal input_direction_changed

var input_direction = Vector2() setget set_input_direction

func set_input_direction(value):
	input_direction = value
	emit_signal('input_direction_changed', input_direction)


func _on_MoveUp_button_down():
	self.input_direction.y -= 1


func _on_MoveUp_button_up():
	self.input_direction.y += 1


func _on_MoveDown_button_down():
	self.input_direction.y += 1


func _on_MoveDown_button_up():
	self.input_direction.y -= 1


func _on_MoveLeft_button_down():
	self.input_direction.x -= 1


func _on_MoveLeft_button_up():
	self.input_direction.x += 1


func _on_MoveRight_button_down():
	self.input_direction.x += 1


func _on_MoveRight_button_up():
	self.input_direction.x -= 1
