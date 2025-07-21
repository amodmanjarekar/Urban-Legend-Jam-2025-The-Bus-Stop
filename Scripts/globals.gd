extends Node

var progress: int

var player: Node = null
enum STATES {MOVE, WAIT}
var player_state : STATES

enum CHATS {AUBREY, MOM, TAYLOR}
var current_chat : CHATS

var chat_data : Dictionary = load_from_json("res://Resources/Dialogue/chats.json")

func load_from_json(file_path) -> Dictionary:
	var json_string = FileAccess.get_file_as_string(file_path)
	var json = JSON.new()
	
	var error = json.parse(json_string)
	if error == OK:
		return json.data
	else:
		print("Unexpected data")
		return {}
