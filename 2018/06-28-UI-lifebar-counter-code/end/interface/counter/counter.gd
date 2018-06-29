extends NinePatchRect

func _on_Interface_rupees_updated(count):
	$Number.text = str(count)
