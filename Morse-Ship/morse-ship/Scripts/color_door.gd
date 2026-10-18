class_name Color_door

extends Node2D

@export var platforms : Array[box_platform]
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	for s in platforms:
		s.toggled.connect(check_platforms)
		

func check_platforms(is_on : bool):
	var all_on := platforms.all(func(s : box_platform): return s.is_on)
	if all_on:
		open()
	else:
		close()



func open() -> void:
	collision.set_deferred("disabled", true)
	#sprite.play("open")
	print("kapı açıldı")

func close() -> void:
	collision.set_deferred("disabled", false)
	#sprite.play("close")
	pass
