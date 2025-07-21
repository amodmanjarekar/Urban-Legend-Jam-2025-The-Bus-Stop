extends CharacterBody2D

class_name Player

@export var speed = 100
@onready var _animated_sprite = $AnimatedSprite2D
@onready var player_raycast = $RayCast2D

func _ready() -> void:
	Globals.player = self
	Globals.progress = 0

func _process(delta):
	if (velocity.x > 0):
		_animated_sprite.play("walk_right")
	elif (velocity.x < 0):
		_animated_sprite.play("walk_left")
	elif (velocity.y > 0):
		_animated_sprite.play("walk_front")
	elif (velocity.y < 0):
		_animated_sprite.play("walk_back")
	else:
		_animated_sprite.play("idle")

func _physics_process(delta):
	if Globals.player_state == Globals.STATES.MOVE:
		player_movement(delta)
		move_and_slide()

func player_movement(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
	if velocity != Vector2.ZERO:
		player_raycast.target_position = velocity.normalized() * 32

func _on_enterbus_body_entered(body: Node2D) -> void:
	if body is Player:
		TransitionScreen.fade_out()
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://Scenes/process_3.tscn")
