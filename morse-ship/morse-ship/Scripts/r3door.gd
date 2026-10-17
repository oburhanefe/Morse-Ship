extends Area2D

@export_file("*.tscn") var target_room : String

func _ready() -> void:
	body_entered.connect(r3_entered)

func r3_entered(body: Node2D):
	if body.is_in_group("Player"):
		Transitioner.coming_from = get_tree().current_scene.name
		get_tree().change_scene_to_file.call_deferred(target_room)
