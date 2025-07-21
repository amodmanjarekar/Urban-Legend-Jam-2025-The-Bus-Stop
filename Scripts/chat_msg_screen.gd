extends Control

var progress_aubrey: int
var progress_mom: int
var progress_taylor: int

var msg_scene
var timestamp_scene
var pfp_mc
var pfp_aubrey
var pfp_mom
var pfp_taylor

var curr_chat : String

var max_scroll

func _ready() -> void:
	msg_scene = preload("res://Scenes/chat_message.tscn")
	timestamp_scene = preload("res://Scenes/timestamp.tscn")
	pfp_mc = preload("res://Assets/Sprites/phone/pfp-mc.png")
	pfp_aubrey = preload("res://Assets/Sprites/phone/pfp-aubrey.png")
	pfp_mom = preload("res://Assets/Sprites/phone/pfp-mom.png")
	pfp_taylor = preload("res://Assets/Sprites/phone/pfp-taylor.png")
	
	$ScrollContainer.get_v_scroll_bar().connect("changed", scroll_to_bottom)
	max_scroll = $ScrollContainer.get_v_scroll_bar().max_value

signal nextTextSignal

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_text"):
		nextTextSignal.emit()
	
func fill_chats():
	clear_chats()
	
	match Globals.current_chat:
		Globals.CHATS.AUBREY: curr_chat = "aubrey"
		Globals.CHATS.MOM: curr_chat = "mom"
		Globals.CHATS.TAYLOR: curr_chat = "taylor"
	
	if curr_chat == "aubrey":
		$"chat-pfp".texture = pfp_aubrey
		$"chat-name".text = "Aubrey"
	elif curr_chat == "mom":
		$"chat-pfp".texture = pfp_mom
		$"chat-name".text = "Mom <3"
	elif curr_chat == "taylor":
		$"chat-pfp".texture = pfp_taylor
		$"chat-name".text = "Taylor"
	
	for convo in Globals.chat_data[curr_chat]["convos"]:
		if convo["progress"] > Globals.progress - 1: return
		
		if convo.keys().has("time"):
			var time_instance = timestamp_scene.instantiate()
			time_instance.text = convo["time"]
			$"ScrollContainer/VBoxContainer".add_child(time_instance)
		
		for text in convo["texts"]:
			var msg_instance = msg_scene.instantiate()
			if text.keys().has(curr_chat):
				msg_instance.get_node("msg").text = text[curr_chat]
				match curr_chat:
					"aubrey": msg_instance.get_node("Control/Image").texture = pfp_aubrey
					"mom": msg_instance.get_node("Control/Image").texture = pfp_mom
					"taylor": msg_instance.get_node("Control/Image").texture = pfp_taylor
			else:
				msg_instance.layout_direction = Control.LAYOUT_DIRECTION_RTL
				msg_instance.get_node("msg").text = text["you"]
				msg_instance.get_node("Control/Image").texture = pfp_mc
			$ScrollContainer/VBoxContainer.add_child(msg_instance)
	
	$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value

func send_new_texts() -> void:
	var are_new_chats = false
	
	match Globals.current_chat:
		Globals.CHATS.AUBREY: curr_chat = "aubrey"
		Globals.CHATS.MOM: curr_chat = "mom"
		Globals.CHATS.TAYLOR: curr_chat = "taylor" 
	
	for convo in Globals.chat_data[curr_chat]["convos"]:
		if convo["progress"] == Globals.progress:
			$"typing-dots".visible = true
			
			if convo.keys().has("time"):
				var time_instance = timestamp_scene.instantiate()
				time_instance.text = convo["time"]
				$"ScrollContainer/VBoxContainer".add_child(time_instance)
			
			for i in convo["texts"].size():
				var msg_instance = msg_scene.instantiate()
				if convo["texts"][i].keys().has(curr_chat):
					msg_instance.get_node("msg").text = convo["texts"][i][curr_chat]
					match curr_chat:
						"aubrey": msg_instance.get_node("Control/Image").texture = pfp_aubrey
						"mom": msg_instance.get_node("Control/Image").texture = pfp_mom
						"taylor": msg_instance.get_node("Control/Image").texture = pfp_taylor
				else:
					msg_instance.layout_direction = Control.LAYOUT_DIRECTION_RTL
					msg_instance.get_node("msg").text = convo["texts"][i]["you"]
					msg_instance.get_node("Control/Image").texture = pfp_mc
				$ScrollContainer/VBoxContainer.add_child(msg_instance)
				if i < convo["texts"].size() - 1:
					await nextTextSignal
			$"typing-dots".visible = false
			Globals.progress += 1
			print(Globals.progress)

func clear_chats():
	for child in $ScrollContainer/VBoxContainer.get_children():
		$ScrollContainer/VBoxContainer.remove_child(child)
		child.queue_free()

func scroll_to_bottom(): 
	if max_scroll != $ScrollContainer.get_v_scroll_bar().max_value:
		max_scroll = $ScrollContainer.get_v_scroll_bar().max_value
		$ScrollContainer.scroll_vertical = $ScrollContainer.get_v_scroll_bar().max_value
