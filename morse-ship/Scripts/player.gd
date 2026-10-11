class_name player

extends CharacterBody2D
@export var inp : input_comp
@export var move : movement_comp
@export var anim : anim_comp

@export var sprite : AnimatedSprite2D

@export var left_limit : float
@export var right_limit : float
@export var up_limit : float
@export var bottom_limit : float

var look_dir : Vector2




func _process(delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, up_limit, bottom_limit) 
	inp.update(delta)
	if not inp.move_dir == Vector2.ZERO:
		look_dir = inp.move_dir
	anim.update_anim(sprite, inp.move_dir)
	move.dir = inp.move_dir
	move.move(self)
	
	
