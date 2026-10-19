class_name Door
extends Node2D

@export var salters : Array[Salter]
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	for s in salters:
		s.toggled.connect(_check_salters)

func _check_salters(_is_on: bool) -> void:
	var all_on := salters.all(func(s: Salter): return s.is_on)
	if all_on:
		open()
	else:
		close()

func open() -> void:
	collision.set_deferred("disabled", true)
	sprite.play("opened")
func close() -> void:
	collision.set_deferred("disabled", false)
	sprite.play("closed")
