extends Node2D


func _ready() -> void:
	$Player.connect("attacked", $Dummy, "_on_Player_attacked")
	$Dummy.connect("damaged", $PlayerUI, "_on_Dummy_damaged")