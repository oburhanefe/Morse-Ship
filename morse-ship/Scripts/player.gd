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

var cmd : String = ""
var bots : Array[Bot]
var bots_code : Array[String] = []
var current_accessed_bot : Bot

func _ready() -> void:
	bots.assign(get_tree().get_nodes_in_group("Bot"))
	for i in bots:
		var new_code = i.pass_code.generate_code()
		bots_code.append(new_code)
	print(bots_code)

func _process(delta: float) -> void:
	position.x = clamp(position.x, left_limit, right_limit)
	position.y = clamp(position.y, up_limit, bottom_limit) 
	inp.update(delta)
	if current_accessed_bot == null:
		var curr_code = inp.update_code()
		if curr_code in bots_code and curr_code != "": 
			var bot_index = bots_code.find(curr_code)
			current_accessed_bot = bots[bot_index]
			
	else:
		inp.update_command(cmd)
	
	anim.update_anim(sprite, inp.move_dir)
	move.dir = inp.move_dir
	move.move(self)
