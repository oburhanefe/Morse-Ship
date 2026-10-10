class_name player

extends CharacterBody2D
@export var inp : input_comp
@export var move : movement_comp
@export var anim : anim_comp

@export var anim_player : AnimationPlayer

@export var left_limit : float
@export var right_limit : float
@export var up_limit : float
@export var bottom_limit : float





func _process(delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, up_limit, bottom_limit) 
	inp.update(delta)
	anim.update_anim(anim_player, inp.move_dir)
	move.dir = inp.move_dir
	move.move(self)
	
	
