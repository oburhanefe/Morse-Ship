extends Node

class_name input_comp

const CLICK_THRESHOLD = 0.5
const click_cancel = 3

@export var morse : Decipher
@onready var morse_audio: AudioStreamPlayer2D = $morse_audio


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
		if not morse_audio.playing:
			morse_audio.play()
		
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
		morse_audio.stop()
		return_click()
		click_time = 0.0

	

func return_click() -> bool:
	return is_long

func update_command(cmd : String) -> String:
	
	
	if Input.is_action_just_released("click"):
		morse.command.append("1" if is_long else "0")
		if ilk_deger_silme:
			morse.command.clear()
			ilk_deger_silme = false
		
		print(morse.command)
		cmd = morse.build_command()
		
		
		if cmd in morse.valid_commands:
			print(morse.valid_commands[cmd])
			morse.command.clear()
		
	if Input.is_action_just_pressed("Delete"):
		if not morse.command.is_empty():
			morse.command.pop_back()
			print("deleted")
	
	return cmd
