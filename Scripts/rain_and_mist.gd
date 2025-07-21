extends Node2D

func _ready() -> void:
	$"mist-1/Mist-1-1".position = Vector2(0, 0)
	$"mist-2/Mist-2-1".position = Vector2(0, 0)
	$"mist-3/Mist-3-1".position = Vector2(0, 0)
	
	$"mist-1/Mist-1-2".position = Vector2(-320, 0)
	$"mist-2/Mist-2-2".position = Vector2(-320, 0)
	$"mist-3/Mist-3-2".position = Vector2(-320, 0)

func _process(delta: float) -> void:
	move_mist_1(delta)
	move_mist_2(delta)
	move_mist_3(delta)

func move_mist_1(delta: float):
	$"mist-1/Mist-1-1".position.x += 12 * delta
	if $"mist-1/Mist-1-1".position.x >= 320:
		$"mist-1/Mist-1-1".position.x = 0
	
	$"mist-1/Mist-1-2".position.x += 12 * delta
	if $"mist-1/Mist-1-2".position.x >= 0:
		$"mist-1/Mist-1-2".position.x = -320

func move_mist_2(delta: float):
	$"mist-2/Mist-2-1".position.x += 6 * delta
	if $"mist-2/Mist-2-1".position.x >= 320:
		$"mist-2/Mist-2-1".position.x = 0
	
	$"mist-2/Mist-2-2".position.x += 6 * delta
	if $"mist-2/Mist-2-2".position.x >= 0:
		$"mist-2/Mist-2-2".position.x = -320

func move_mist_3(delta: float):
	$"mist-3/Mist-3-1".position.x += 2 * delta
	if $"mist-3/Mist-3-1".position.x >= 320:
		$"mist-3/Mist-3-1".position.x = 0
	
	$"mist-3/Mist-3-2".position.x += 2 * delta
	if $"mist-3/Mist-3-2".position.x >= 0:
		$"mist-3/Mist-3-2".position.x = -320
