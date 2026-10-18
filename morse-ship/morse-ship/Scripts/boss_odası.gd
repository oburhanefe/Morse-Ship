extends Node2D

@export var boss: Boss
@export var plr : player

@export var long : AudioStreamPlayer2D
@export var short : AudioStreamPlayer2D

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("click"):
		if plr.inp.is_long:
			long.play()
			plr.inp.label.text += "-"
		else:
			short.play()
			plr.inp.label.text += "."
