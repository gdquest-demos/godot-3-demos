extends HBoxContainer

export(int) var minimum_value = 0 setget set_minimum_value
export(int) var maximum_value = 34 setget set_maximum_value
export(int) var current_value = 12 setget set_current_value

func set_current_value(value):
	if not has_node('TextureProgress'):
		return
	current_value = value
	$TextureProgress.value = value
	update_count_text()

func set_minimum_value(value):
	if not has_node('TextureProgress'):
		return
	minimum_value = value
	$TextureProgress.min_value = value

func set_maximum_value(value):
	if not has_node('TextureProgress'):
		return
	maximum_value = value
	$TextureProgress.max_value = value
	update_count_text()

func update_count_text():
	$Count/Number.text = str(current_value) + '/' + str(maximum_value)
