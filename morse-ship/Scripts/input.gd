extends Node

class_name input_comp

const CLICK_THRESHOLD = 0.5
const click_cancel = 3

var move_dir = Vector2.ZERO
var is_long = false
var click_time := 0.00
var click_cd := 1.00
var click_on_cd = false

func update(delta) -> void:
	move_dir = Input.get_vector("left","right","up","down")
	
	if click_on_cd:
		click_cd -= delta
		if click_cd <= 0:
			click_on_cd = false
			click_cd = 1
		return
	
	if Input.is_action_pressed("click") and not click_on_cd:
		
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

	

func return_click() -> bool:
	return is_long
