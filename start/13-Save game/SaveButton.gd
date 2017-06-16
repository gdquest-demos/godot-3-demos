extends Button

onready var Save = get_node('/root/Save')


func _on_SaveButton_pressed():
	Save.save_game()
	
