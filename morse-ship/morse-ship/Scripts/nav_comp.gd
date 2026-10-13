class_name nav_comp 
extends Node


@export var nav_agent : NavigationAgent2D
var plr : Node2D

func _ready() -> void:
	plr = get_tree().get_first_node_in_group("Player")
	nav_agent.target_desired_distance = 1
func make_path() -> void:
	if plr:
		nav_agent.target_position = plr.global_position
