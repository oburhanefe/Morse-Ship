extends Node

class_name input_comp

const CLICK_THRESHOLD = 0.3
const click_cancel = 3

@export var morse : Decipher
@export var plr : player
@onready var morse_short: AudioStreamPlayer2D = $morse_short
@onready var morse_long: AudioStreamPlayer2D = $morse_long


var move_dir = Vector2.ZERO
var is_long = false
var click_time := 0.00
var click_cd := 1.00
var click_on_cd = false
var is_clicking = false
var not_clicked_time = 5.0
var code : String = ""
var code_length : int = 3
var ilk_deger_silme = true



func update(delta) -> void:
	
	move_dir = Input.get_vector("left","right","up","down")
	
	if not Input.is_action_pressed("click"):
		is_clicking = false
	
	if Input.is_action_just_pressed("Delete"):
		plr.current_accessed_bot.accessed = false
		plr.current_accessed_bot = null
		morse.command.clear()
		ilk_deger_silme = true
	
	if not morse.command.is_empty() and not is_clicking:
		not_clicked_time -= delta
		if not_clicked_time <= 0:
			morse.command.clear()
			print("cleared")
			click_on_cd = true
			not_clicked_time = 5.0
			

	if click_on_cd:
		click_cd -= delta
		if click_cd <= 0:
			click_on_cd = false
			click_cd = 1
		return
		
		
	if Input.is_action_pressed("click") and not click_on_cd:
		is_clicking = true
		not_clicked_time = 5.0
		
		
		if click_time >= click_cancel:
			click_time = 0
			click_on_cd = true
			return
			
		else:
			click_time += delta
			
		if click_time >= CLICK_THRESHOLD:
			is_long = true

		else:
			is_long = false
	if Input.is_action_just_released("click"):
		return_click()
		click_time = 0.0
		if is_long:
			morse_long.play()
		else:
			morse_short.play()

	

func return_click() -> bool:
	return is_long

func update_command(cmd : String) -> String:
	
	if Input.is_action_just_released("click") and plr.current_accessed_bot.accessed:
		morse.command.append("1" if is_long else "0")
		if ilk_deger_silme:
			morse.command.clear()
			ilk_deger_silme = false
		
		print(morse.command)
		cmd = morse.build_command()
		
		
		if cmd in morse.valid_commands:
			print(morse.valid_commands[cmd])
			morse.command.clear()
		
	
	
	return cmd
