extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"mainhall":
			player.global_position = Vector2(80, -15) 
		"L2":
			player.global_position = Vector2(-544, -96)
		"L3":
			player.global_position = Vector2(-544, 80)
	
