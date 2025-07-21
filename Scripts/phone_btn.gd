extends Control

var phone_btn
var phone_btn_alert

func _ready() -> void:
	phone_btn = preload("res://Assets/Sprites/Icons/phone-icon.png")
	phone_btn_alert = preload("res://Assets/Sprites/Icons/phone-icon-alert.png")
	
	$TextureButton.texture_normal = phone_btn

func check_chat_progress() -> void:
	for convo in Globals.chat_data["aubrey"]["convos"]:
		if convo["progress"] == Globals.progress:
			$TextureButton.texture_normal = phone_btn_alert
			return
		
	for convo in Globals.chat_data["mom"]["convos"]:
		if convo["progress"] == Globals.progress:
			$TextureButton.texture_normal = phone_btn_alert
			return
			
	for convo in Globals.chat_data["taylor"]["convos"]:
		if convo["progress"] == Globals.progress:
			$TextureButton.texture_normal = phone_btn_alert
			return
