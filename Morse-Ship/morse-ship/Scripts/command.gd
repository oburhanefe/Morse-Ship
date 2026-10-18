extends Node2D


var to_boss := false

func _process(delta: float) -> void:
	if to_boss:
		get_tree().change_scene_to_file("res://Scenes/Boss_Odası.tscn")
	
	if SaveManager.keys.size() >= 2:
		to_boss = true
