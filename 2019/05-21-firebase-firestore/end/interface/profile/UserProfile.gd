extends Control

onready var http : HTTPRequest = $HTTPRequest
onready var nickname : LineEdit = $Container/VBoxContainer2/Name/LineEdit
onready var character_class : LineEdit = $Container/VBoxContainer2/Class/LineEdit
onready var notification : Label = $Container/Notification
onready var strength : Slider = $Container/VBoxContainer2/Strength/Slider
onready var intelligence : Slider = $Container/VBoxContainer2/Intelligence/Slider
onready var dexterity : Slider = $Container/VBoxContainer2/Dexterity/Slider

var new_profile := false
var information_sent := false
var profile := {
	"nickname": {},
	"character_class": {},
	"strength": {},
	"intelligence": {},
	"dexterity": {}
} setget set_profile


func _ready() -> void:
	Firebase.get_document("users/%s" % Firebase.user_info.id, http)


func _on_HTTPRequest_request_completed(result: int, response_code: int, headers: PoolStringArray, body: PoolByteArray) -> void:
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	match response_code:
		404:
			notification.text = "Please, enter your information"
			new_profile = true
			return
		200:
			if information_sent:
				notification.text = "Information saved successfully"
				information_sent = false
			self.profile = result_body.fields


func _on_ConfirmButton_pressed() -> void:
	if nickname.text.empty() or character_class.text.empty():
		notification.text = "Please, enter your nickname and class"
		return
	profile.nickname = { "stringValue": nickname.text }
	profile.character_class = { "stringValue": character_class.text }
	profile.strength = { "integerValue": strength.value }
	profile.intelligence = { "integerValue": intelligence.value }
	profile.dexterity = { "integerValue": dexterity.value }
	match new_profile:
		true:
			Firebase.save_document("users?documentId=%s" % Firebase.user_info.id, profile, http)
		false:
			Firebase.update_document("users/%s" % Firebase.user_info.id, profile, http)
	information_sent = true


func set_profile(value: Dictionary) -> void:
	profile = value
	nickname.text = profile.nickname.stringValue
	character_class.text = profile.character_class.stringValue
	strength.value = int(profile.strength.integerValue)
	intelligence.value = int(profile.intelligence.integerValue)
	dexterity.value = int(profile.dexterity.integerValue)
