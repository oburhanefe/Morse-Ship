class_name Decipher 
extends Node

var command : Array[String] = []
var valid_commands = {
		"1010" : "stun",
		"0010" : "slow",
}

var stun_dur = 1.5


func build_command() -> String:
	var cmd := ""
	for letter in command:
		if not letter.is_empty():
			cmd += letter
	if len(command) >=4:
		command.pop_front()
	return cmd


func execute_com(bot : Bot, cmd : String, delta : float):
	match cmd:
		
		"stun":
			var orj_speed = bot.move_comp.speed
			bot.move_comp.speed = Vector2.ZERO
			while stun_dur > 0:
				stun_dur -= delta
			stun_dur = 1.5
			bot.move_comp.speed = orj_speed
