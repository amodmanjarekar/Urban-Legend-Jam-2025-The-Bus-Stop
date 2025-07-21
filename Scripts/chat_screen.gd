extends Control

var alert

func _ready() -> void:
	alert = preload("res://Assets/Sprites/Icons/alert.png")
	
	$"Chat-screen/alert".visible = false
	$"Chat-screen/alert2".visible = false
	$"Chat-screen/alert3".visible = false

func _process(delta: float) -> void:
	for convo in Globals.chat_data["aubrey"]["convos"]:
		if convo["progress"] == Globals.progress:
			$"Chat-screen/alert".visible = true
		else:
			$"Chat-screen/alert".visible = false
		
	for convo in Globals.chat_data["mom"]["convos"]:
		if convo["progress"] == Globals.progress:
			$"Chat-screen/alert2".visible = true
		else:
			$"Chat-screen/alert2".visible = false
			
	for convo in Globals.chat_data["taylor"]["convos"]:
		if convo["progress"] == Globals.progress:
			$"Chat-screen/alert3".visible = true
		else:
			$"Chat-screen/alert3".visible = false
