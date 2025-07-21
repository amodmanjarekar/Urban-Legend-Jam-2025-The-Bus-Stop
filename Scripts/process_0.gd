extends Node2D

var begin_timer : Timer
var bus_timer : Timer

func _ready() -> void:
	Globals.progress = 0
	TransitionScreen.fade_in()
	Globals.player_state = Globals.STATES.WAIT
	
	$"Bus-outside".position = Vector2(-600, 217)
	
	begin_timer = Timer.new()
	add_child(begin_timer)
	begin_timer.one_shot = true
	begin_timer.wait_time = 2
	begin_timer.timeout.connect(_begin_timer_timeout)
	begin_timer.start()
	
	print(Globals.progress)

func _begin_timer_timeout():
	Globals.progress = 1
	$"CanvasLayer/phone-btn".check_chat_progress()
	Globals.player_state = Globals.STATES.MOVE
	
	print(Globals.progress)

func _process(delta: float) -> void:
	if Globals.progress == 2:
		bus_timer = Timer.new()
		add_child(bus_timer)
		bus_timer.one_shot = true
		bus_timer.wait_time = 10
		bus_timer.timeout.connect(_bus_timer_timeout)
		bus_timer.start()

func _bus_timer_timeout():
	var tween = create_tween()
	tween.tween_property($"Bus-outside", "position", Vector2(-136, 217), 2)
	tween.finished.connect(_bus_tween_finish)

func _bus_tween_finish():
	$"enter-bus/CollisionShape2D".disabled = false
