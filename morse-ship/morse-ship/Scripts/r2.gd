extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"R1":
			player.global_position = Vector2(0, 120) 
		"botanic":
			player.global_position = Vector2(0, -295)
