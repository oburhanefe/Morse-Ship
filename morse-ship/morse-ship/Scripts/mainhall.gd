extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"L1":
			player.global_position = Vector2(-168, -48) 
		"R1":
			player.global_position = Vector2(-576, -110)
		"Command":
			player.global_position = Vector2(-576, 80)
	
	Transitioner.coming_from = ""
