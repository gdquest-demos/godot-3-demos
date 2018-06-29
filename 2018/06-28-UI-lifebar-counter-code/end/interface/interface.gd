extends Control

signal health_updated(value)
signal rupees_updated(count)

func _ready():
	var health_node = null
	for node in get_tree().get_nodes_in_group("actors"):
		if node.name == "Player":
			health_node = node.get_node("Health")
			break
	get_node("Bars/LifeBar").initialize(health_node.max_health)

func _on_Health_health_changed(health):
	emit_signal("health_updated", health)

func _on_Purse_rupees_changed(count):
	emit_signal("rupees_updated", count)
