extends CanvasLayer

@onready var color_rect = $ColorRect
@onready var anim_player = $AnimationPlayer

func _ready():
	color_rect.visible = false
		
func fade_in():
	color_rect.visible = true
	anim_player.play("fade_to_normal")

func fade_out():
	color_rect.visible = true
	anim_player.play("fade_to_black")
