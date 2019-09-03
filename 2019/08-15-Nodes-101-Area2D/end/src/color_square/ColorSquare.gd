extends Area2D
"""
Shows how to change a property on mouse over
"""


export var color_one: Color
export var color_two: Color


func _on_ColorSquare_mouse_entered():
	modulate = color_two

func _on_ColorSquare_mouse_exited():
	modulate = color_one
