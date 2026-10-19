extends Node2D




func _ready() -> void:
	var plr = get_tree().get_first_node_in_group("Player")
	match Transitioner.coming_from:
		"mainhall":
			plr.global_position = Vector2(-265, -0) 
		"R2":
			plr.global_position = Vector2(240, -85)
		"R3":
			plr.global_position = Vector2(240, 90)
	
