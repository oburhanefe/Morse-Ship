extends Node

class_name input_comp

var move_dir = Vector2.ZERO

func update() -> void:
	move_dir = Input.get_vector("left","right","up","down")
	
