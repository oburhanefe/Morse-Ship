class_name Decipher 
extends Node

var command : Array[String] = []
var valid_commands = {
		"1010" : "stun",
}
func _ready() -> void:
	command.resize(4)
	
	


func build_command() -> String:
	var cmd := ""
	for letter in command:
		if not letter.is_empty():
			cmd += letter
	return cmd
