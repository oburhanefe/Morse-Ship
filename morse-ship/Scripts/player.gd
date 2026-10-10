class_name player

extends CharacterBody2D
@export var inp : input_comp
@export var move : movement_comp


func _ready() -> void:
	pass 



func _process(_delta: float) -> void:
	inp.update()
	move.dir = inp.move_dir
	move.move(self)
	
	
