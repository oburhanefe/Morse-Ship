class_name Decipher 
extends Node

var command : Array[String] = []
var valid_commands = {
		"1010" : "stun",
}

func is_empty() -> bool:
	if len(command) == 0:
		return true
	else:
		return false



func build_command() -> String:
	var cmd := ""
	for letter in command:
		if not letter.is_empty():
			cmd += letter
	if len(command) >=4:
		command.pop_front()
	return cmd
