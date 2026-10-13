class_name PassCode
extends Resource

@export var length : int
var code : String = ""

func generate_code() -> String:
	for count in range(length):
		var rand = randf_range(0, 100)
		code += "1" if rand <= 50 else "0"
	print(code)
	return code
