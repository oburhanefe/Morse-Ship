extends Node

class_name input_comp

@onready var morse_audio: AudioStreamPlayer2D = $morse_audio

const CLICK_THRESHOLD = 0.3
const click_cancel = 1.5

var move_dir = Vector2.ZERO
var is_long = false
var click_time := 0.00
var click_cd := 1.00
var click_on_cd = false
var is_clicking = false
var is_clicking_cd = 3

func update(delta) -> void:
	move_dir = Input.get_vector("left","right","up","down")
	

	
	
	
	if click_on_cd:
		click_cd -= delta
		if click_cd <= 0:
			click_on_cd = false
			click_cd = 1
		return
	
	if Input.is_action_pressed("click") and not click_on_cd:
		
		
		if not morse_audio.playing:
			morse_audio.play()
		
		if click_time >= click_cancel:
			click_time = 0
			click_on_cd = true
			morse_audio.stop()
			return
			
		else:
			click_time += delta
			
		if click_time >= CLICK_THRESHOLD:
			is_long = true
		else:
			is_long = false
		
	if Input.is_action_just_released("click"):
		morse_audio.stop()
		
		if not click_on_cd and click_time > 0:
			if click_time >= CLICK_THRESHOLD:
				print("long")
			else:
				print("short")
		
		click_time = 0.00
		is_long = false

	
	
