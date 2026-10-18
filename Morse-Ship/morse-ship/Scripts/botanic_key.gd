class_name key2

extends Node2D

@export var sprite : AnimatedSprite2D
@export var area : Area2D

var is_picked := false
var plr : player

func _ready():
	
	area.body_entered.connect(on_body_entered)
	
	
	
func on_body_entered(body : Node2D):
	if body.is_in_group("Player"):
		is_picked = true
		sprite.hide()
		SaveManager.keys.append(self)
