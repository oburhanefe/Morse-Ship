class_name player

extends CharacterBody2D
@export var inp : input_comp
@export var move : movement_comp
@export var anim : anim_comp
@export var decipher : Decipher
@export var sprite : AnimatedSprite2D


@onready var walk_audio: AudioStreamPlayer2D = $Walk_Audio

@export var left_limit : float
@export var right_limit : float
@export var up_limit : float
@export var bottom_limit : float


var cmd : String = ""
var current_accessed_bot : Bot
var bots : Array[Bot]
var look_dir : Vector2

func _ready() -> void:
	bots.assign(get_tree().get_nodes_in_group("Bot"))

func _process(delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, up_limit, bottom_limit) 
	inp.update(delta)
	if not inp.move_dir == Vector2.ZERO:
		look_dir = inp.move_dir
	
	for i in bots:
		if i.mouse_ustunde_mi and Input.is_action_just_pressed("click"):
			if current_accessed_bot == null:
				current_accessed_bot = i
			else:
				if current_accessed_bot != i:
					current_accessed_bot = i
					inp.ilk_deger_silme = true
			print(current_accessed_bot.name)

	if current_accessed_bot:
		var new_cmd = inp.update_command(cmd)
		
		if new_cmd in decipher.valid_commands:
			decipher.execute_com(current_accessed_bot,decipher.valid_commands[new_cmd], delta)
			print(current_accessed_bot.move_comp.speed)
	
	anim.update_anim(sprite, inp.move_dir, look_dir, walk_audio)
	move.dir = inp.move_dir
	move.move(self)
	
