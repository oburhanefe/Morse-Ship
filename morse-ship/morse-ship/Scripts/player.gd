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

var current_boss : Boss

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
			current_boss = null
			if current_accessed_bot == null:
				current_accessed_bot = i
				current_accessed_bot.accessed = true
				inp.ilk_deger_silme = true
				
			else:
				if current_accessed_bot != i:
					current_accessed_bot.accessed = false
					if not current_accessed_bot.accessed:
						print("shader off")
					current_accessed_bot = i
					current_accessed_bot.accessed = true
					inp.ilk_deger_silme = true
			print(current_accessed_bot.name)
			
	for b in get_tree().get_nodes_in_group("Boss"):
		if b.mouse_ustunde_mi and Input.is_action_just_pressed("click"):
			if current_boss != b:
				if current_accessed_bot:
					current_accessed_bot.accessed = false
				current_accessed_bot = null
				current_boss = b
				decipher.command.clear()
				inp.ilk_deger_silme = true
				print("boss seçildi")

	if current_accessed_bot or current_boss:
		var new_cmd = inp.update_command(cmd)

		if new_cmd in decipher.valid_commands:
			var cmd_name = decipher.valid_commands[new_cmd]
			if current_boss:
				decipher.execute_on_boss(current_boss, cmd_name)
			else:
				decipher.execute_com(current_accessed_bot, cmd_name)
				print(current_accessed_bot.move_comp.speed)
	
	anim.update_anim(sprite, inp.move_dir, look_dir, walk_audio)
	move.dir = inp.move_dir
	move.move(self)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
	
		
		if collider and collider.is_in_group("box") and collider.has_method("hizi_aktar"):
			var itme_yönü = -collision.get_normal()
			var itme_gücü = 75
			collider.hizi_aktar(itme_gücü * itme_yönü)
		
		
func select_bot(b : Bot) -> void:
	if current_accessed_bot == b and current_boss == null:
		return
	current_boss = null
	current_accessed_bot = b
	decipher.command.clear()
	inp.ilk_deger_silme = true

func select_boss(b : Boss) -> void:
	if current_boss == b:
		return
	current_accessed_bot = null
	current_boss = b
	decipher.command.clear()
	inp.ilk_deger_silme = true
