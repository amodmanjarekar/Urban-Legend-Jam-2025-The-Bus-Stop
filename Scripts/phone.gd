extends Control

var is_open = false
var tween: Tween

enum SCREENS {HOME, CHAT, CHAT_MSG, CONTACTS, GALLERY}
var current_screen : SCREENS = SCREENS.HOME

var selected_app = 0
var selected_chat = 1

func _ready() -> void:
	$"chat-screen".visible = false
	$"chat-msg-screen".visible = false
	close_phone()

func _process(delta: float) -> void:
	if is_open:
		if current_screen == SCREENS.HOME:
			handle_home_screen()
		elif current_screen == SCREENS.CHAT:
			handle_chat_screen()
		elif current_screen == SCREENS.CHAT_MSG:
			handle_chatmsg_screen()
	else:
		if Input.is_action_just_pressed("phone_next"):
			open_phone()

func close_phone():
	selected_app = 3
	$"home-screen/App-selector".position.x = 22
	
	tween = create_tween()
	tween.tween_property($"home-screen", "position", Vector2(160, 270), 0.2)
	is_open = false
	Globals.player_state = Globals.STATES.MOVE

func open_phone():
	is_open = true
	Globals.player_state = Globals.STATES.WAIT
	current_screen = SCREENS.HOME
	tween = create_tween()
	tween.tween_property($"home-screen", "position", Vector2(160, 90), 0.2)
	
	selected_app = 3
	$"home-screen/App-selector".position.x = 22

func handle_home_screen():
	if Input.is_action_just_pressed("move_left"):
		if (selected_app == 1):
			selected_app = 3
			$"home-screen/App-selector".position.x = 22
		else:
			selected_app -= 1
			$"home-screen/App-selector".position.x -= 22
	
	if Input.is_action_just_pressed("move_right"):
		if (selected_app == 3):
			selected_app = 1
			$"home-screen/App-selector".position.x = -22
		else:
			selected_app += 1
			$"home-screen/App-selector".position.x += 22
	
	if Input.is_action_just_pressed("phone_next") and selected_app:
		if selected_app == 1:
			pass
		if selected_app == 2:
			pass
		if selected_app == 3:
			$"home-screen".visible = false
			$"chat-screen".visible = true
			current_screen = SCREENS.CHAT
	
	if Input.is_action_just_pressed("phone_back"):
		close_phone()
	

func handle_chat_screen():
	if Input.is_action_just_pressed("move_down"):
		if selected_chat == 3:
			selected_chat = 1
			$"chat-screen/Chat-selector".position.y = -38
		else:
			selected_chat += 1
			$"chat-screen/Chat-selector".position.y += 17
	
	if Input.is_action_just_pressed("move_up"):
		if selected_chat == 1:
			selected_chat = 3
			$"chat-screen/Chat-selector".position.y = -4
		else:
			selected_chat -= 1
			$"chat-screen/Chat-selector".position.y -= 17
	
	if Input.is_action_just_pressed("phone_next"):
		match selected_chat:
			1:
				Globals.current_chat = Globals.CHATS.AUBREY
			2:
				Globals.current_chat = Globals.CHATS.MOM
			3:
				Globals.current_chat = Globals.CHATS.TAYLOR
		$"chat-screen".visible = false
		$"chat-msg-screen".visible = true
		$"chat-msg-screen".fill_chats()
		current_screen = SCREENS.CHAT_MSG
		$"chat-msg-screen".send_new_texts()
	
	if Input.is_action_just_pressed("phone_back"):
		$"chat-screen".visible = false
		$"home-screen".visible = true
		current_screen = SCREENS.HOME

func handle_chatmsg_screen():
	if Input.is_action_pressed("move_up"):
		$"chat-msg-screen/ScrollContainer".scroll_vertical -= 8
	if Input.is_action_pressed("move_down"):
		$"chat-msg-screen/ScrollContainer".scroll_vertical += 8
	
	if Input.is_action_just_pressed("phone_back"):
		$"chat-msg-screen".visible = false
		$"chat-screen".visible = true
		current_screen = SCREENS.CHAT

func _on_texture_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		close_phone()
	else:
		open_phone()
