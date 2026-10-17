extends Node2D

@onready var player: player = $Player


func _ready() -> void:
	match Transitioner.coming_from:
		"mainhall":
			player.global_position = Vector2(80, -15) 
		"L2":
			player.global_position = Vector2(-576, -110)
		"L3":
			player.global_position = Vector2(-576, 80)
	
	Transitioner.coming_from = ""
