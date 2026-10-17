class_name Decipher 
extends Node


@export var inp : input_comp

var command : Array[String] = []
var valid_commands = {
		"1010" : "stun",
		"0010" : "slow",
		"1000" : "short_circuit",
		"0101" : "mad_cow"
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


func execute_com(bot : Bot, cmd : String):
	match cmd:
		"stun":
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
		

		"short_circuit":
			var confused_timer := Timer.new()
			confused_timer.autostart = false
			confused_timer.one_shot = true
			confused_timer.wait_time = 3
			bot.add_child(confused_timer)
			confused_timer.start()
			bot.move_comp.speed *= -1
			await confused_timer.timeout
			bot.move_comp.speed *= -1
			confused_timer.queue_free()

		"mad_cow":#Tam kafama oturmadı öylesine ekledim
			var rand_range := 300
			var mad_timer := Timer.new()
			mad_timer.autostart = false
			mad_timer.one_shot = true
			mad_timer.wait_time = 3
			bot.add_child(mad_timer)
			mad_timer.start()
			var orj_speed : Vector2 = bot.move_comp.speed
			var elapsed_time := 0.0
			while elapsed_time < 3:
				bot.move_comp.speed = Vector2(randf_range(-rand_range, rand_range), randf_range(-rand_range, rand_range))
				await bot.get_tree().create_timer(0.1).timeout
				elapsed_time += 0.1
			bot.move_comp.speed = orj_speed
			mad_timer.queue_free()
		_:
			print("Komut Çalışmadı")
