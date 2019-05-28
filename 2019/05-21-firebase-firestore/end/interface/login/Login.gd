extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var username : LineEdit = $Container/VBoxContainer2/Username/LineEdit
onready var password : LineEdit = $Container/VBoxContainer2/Password/LineEdit
onready var notification : Label = $Container/Notification


func _on_LoginButton_pressed() -> void:
	if username.text.empty() or password.text.empty():
		notification.text = "Please, enter your username and password"
		return
	Firebase.login(username.text, password.text, http)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var response_body := JSON.parse(body.get_string_from_ascii())
	if response_code != 200:
		notification.text = response_body.result.error.message.capitalize()
		print(notification.text)
	else:
		notification.text = "Sign in sucessful!"
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://interface/profile/UserProfile.tscn")
