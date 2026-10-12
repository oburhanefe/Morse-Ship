class_name Decipher 
extends Node

var command : Array[String] = []
var bot_access_code : Array[String] = []
var valid_commands = {
		"1010" : "stun",
}


func build_command() -> String:
	var cmd := ""
	for letter in command:
		if not letter.is_empty():
			cmd += letter
	if len(command) >=4:
		command.pop_front()
	return cmd


func check_code(given_code : String, correct_code: String) -> bool:
	if given_code == correct_code:
		return true
	return false
