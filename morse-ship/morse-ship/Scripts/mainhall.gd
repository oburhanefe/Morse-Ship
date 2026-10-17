extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"L1":
			player.global_position = Vector2(-168, -48) 
		"R1":
			player.global_position = Vector2(175, -48)
		"Kaptan_odasi":
			player.global_position = Vector2(0, -155)
		"command":
			player.global_position = Vector2(0, -155)
