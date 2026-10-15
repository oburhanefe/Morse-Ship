class_name Decipher 
extends Node


@export var inp : input_comp

var command : Array[String] = []
var valid_commands = {
		"1010" : "stun",
		"0010" : "slow",
}

var stun_dur = 1.5
var slow_dur = 2.0


func build_command() -> String:
	var cmd := ""
	for letter in command:
		if not letter.is_empty() and not inp.click_on_cd:
			cmd += letter
	if len(command) >=4:
		command.pop_front()
	return cmd


func execute_com(bot : Bot, cmd : String, delta : float):
	match cmd:
		"stun":
			print("Çalışdı")
			var stun_timer := Timer.new()
			stun_timer.autostart = false
			stun_timer.one_shot = true
			stun_timer.wait_time = stun_dur
			bot.add_child(stun_timer)
			var orj_speed = bot.move_comp.speed
			bot.move_comp.speed = Vector2.ZERO
			stun_timer.start()
			await  stun_timer.timeout
			bot.move_comp.speed = orj_speed
			stun_timer.queue_free()

		"slow":
			print("Çalışdı")
			var slow_timer := Timer.new()
			slow_timer.autostart = false
			slow_timer.one_shot = true
			slow_timer.wait_time = slow_dur
			bot.add_child(slow_timer)
			var orj_speed = bot.move_comp.speed
			bot.move_comp.speed = orj_speed / 2
			slow_timer.start()
			await  slow_timer.timeout
			bot.move_comp.speed = orj_speed
			slow_timer.queue_free()
		_:
			print("Komut Çalışmadı")
