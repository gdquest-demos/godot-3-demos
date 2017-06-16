extends Label

var Player = null

func _ready():
	Player = get_parent()
	set_text("Max health: %s" % Player.max_health)