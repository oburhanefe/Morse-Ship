class_name kutu
extends CharacterBody2D

@export var move : movement_comp



var kutu_hizi := Vector2.ZERO

func hizi_aktar(plr_hizi : Vector2):
	kutu_hizi = plr_hizi
	
func _process(delta: float) -> void:
	velocity = kutu_hizi
	move_and_slide()
	
	kutu_hizi = Vector2.ZERO
