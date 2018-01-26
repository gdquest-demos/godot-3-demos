extends Button

onready var Save = get_node('/root/Save')


func _on_LoadButton_pressed():
	Save.load_game()
