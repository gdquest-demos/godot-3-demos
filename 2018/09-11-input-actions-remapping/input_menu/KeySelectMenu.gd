extends Panel

signal key_selected(scancode)

func _ready():
	set_process_input(false)

func _input(event):
	if not event.is_pressed():
		return
	emit_signal("key_selected", event.scancode)
	close()

func open():
	show()
	set_process_input(true)

func close():
	hide()
	set_process_input(false)

