extends Area2D

@export_file("*.tscn") var target_room : String
@onready var npc: CharacterBody2D = $"../NPC"

func _ready() -> void:
	body_entered.connect(command_door_entered)

func command_door_entered(body: Node2D):
	if body.is_in_group("Player") and npc.can_leave:
		Transitioner.coming_from = get_tree().current_scene.name
		get_tree().change_scene_to_file.call_deferred(target_room)
		npc.can_leave = false
