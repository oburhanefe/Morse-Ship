extends Node

class_name input_comp

const CLICK_THRESHOLD = 0.5
const click_cancel = 3

@export var morse : Decipher


var move_dir = Vector2.ZERO
var is_long = false
var click_time := 0.00
var click_cd := 1.00
var click_on_cd = false
var is_clicking = false
var not_clicked_time = 5.0

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
		
		if click_time == click_cancel:
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

func update_command(plr : player, cmd : String) -> void:
	if Input.is_action_just_released("click"):
		plr.decipher.command.append("1" if plr.inp.is_long else "0")
		print(plr.decipher.command.back())
		print(plr.decipher.command)
		cmd = plr.decipher.build_command()
		if cmd in plr.decipher.valid_commands:
			print(plr.decipher.valid_commands[cmd])
			plr.decipher.command.clear()
	if Input.is_action_just_pressed("Delete"):
		if not plr.decipher.command.is_empty():
			plr.decipher.command.pop_back()
			print("deleted")
