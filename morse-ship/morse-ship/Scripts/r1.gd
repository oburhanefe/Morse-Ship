extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"mainhall":
			player.global_position = Vector2(-265, -0) 
		"R2":
			player.global_position = Vector2(240, -85)
		"R3":
			player.global_position = Vector2(240, 90)
	
