class_name player

extends CharacterBody2D
@export var inp : input_comp
@export var move : movement_comp
@export var anim : anim_comp
@export var decipher : Decipher
@export var sprite : AnimatedSprite2D

@export var left_limit : float
@export var right_limit : float
@export var up_limit : float
@export var bottom_limit : float

var cmd : String

var look_dir : Vector2




func _process(delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, up_limit, bottom_limit) 
	inp.update(delta)
	if Input.is_action_just_released("click"):
		decipher.command.append("1" if inp.is_long else "0")
		print(decipher.command.back())
		cmd = decipher.build_command()
		if cmd in decipher.valid_commands:
			print(decipher.valid_commands[cmd])
			decipher.command.clear()
	if Input.is_action_just_pressed("Delete"):
		if not decipher.command.is_empty():
			decipher.command.pop_back()
			print("deleted")
	if not inp.move_dir == Vector2.ZERO:
		look_dir = inp.move_dir
	anim.update_anim(sprite, inp.move_dir)
	move.dir = inp.move_dir
	move.move(self)
	
	
