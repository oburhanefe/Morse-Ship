extends Area2D

@export_file("*.tscn") var target_room : String
@onready var npc: CharacterBody2D = $"../NPC"

func _ready() -> void:
	body_entered.connect(main_entered)

func main_entered(body: Node2D):
	if body.is_in_group("Player") and npc.can_leave:
		MainTheme.play()
		Transitioner.coming_from = get_tree().current_scene.name
		get_tree().change_scene_to_file.call_deferred(target_room)
