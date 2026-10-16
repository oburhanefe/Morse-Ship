class_name switch

extends Node2D

@onready var area: Area2D = $Area2D

var player_inside := false

func _ready() -> void:
	area.body_entered.connect(on_body_entered)
	area.body_exited.connect(on_body_exited)
	
func on_body_entered(body : Node2D):
	if body is player:
		player_inside = true
		print("oyuncu girdi")
	
	
	
func on_body_exited(body : Node2D):
	if body is player:
		player_inside = false
		print("oyuncu çıktı")
		
func _process(delta: float) -> void:
	if player_inside and Input.is_action_just_pressed("interact"):
		print("şalter kullanıldı")
