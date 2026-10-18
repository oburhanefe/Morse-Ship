extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var step = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		animated_sprite_2d.play("page2")
		step += 1
	if step == 2:
		get_tree().change_scene_to_file("res://Scenes/intro.tscn")
	
