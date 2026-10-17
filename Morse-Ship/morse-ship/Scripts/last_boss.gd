class_name Boss

extends Node2D

signal healt_changed(current: float, max: float)
signal died

@export var max_can := 100.0
@export var area : Area2D
@export var sprite : AnimatedSprite2D
@export var hit_cd := 15.00
@export_range(0.0, 1.0) var stun_dmg_ratio := 0.25 

var healt : float
var mouse_ustunde_mi = false
var can_be_hit = true
var accessed := true

func _ready() -> void:
	add_to_group("Boss")
	healt = max_can
	area.mouse_entered.connect(func(): mouse_ustunde_mi = true)
	area.mouse_exited.connect(func(): mouse_ustunde_mi = false)
	healt_changed.emit(healt, max_can)
	
func take_hit():
	if not can_be_hit or healt <= 0.0:
		return
	can_be_hit = false
	healt = max(healt - max_can * stun_dmg_ratio, 0.0)
	healt_changed.emit(healt, max_can)
	
	var tw := create_tween()
	tw.tween_property(sprite, "modulate", Color.RED, 0.1)
	tw.tween_property(sprite, "modulate", Color.WHITE, 0.2)
	
	if healt <= 0:
		died.emit()
		queue_free()
		return

	await get_tree().create_timer(hit_cd).timeout
	can_be_hit = true
