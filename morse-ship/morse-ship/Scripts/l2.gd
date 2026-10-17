extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"L1":
			player.global_position = Vector2(0, 125) 
		"Computer_room":
			player.global_position = Vector2(0, -285)
