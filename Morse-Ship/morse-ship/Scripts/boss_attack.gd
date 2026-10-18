class_name attack
extends Node2D

var is_attacking := false
var did_hit := false
@export var area : Area2D
@export var sprite : AnimatedSprite2D
@export var attack_interval := 4.0
@export var windup_time := 1.0     
@export var hit_time := 0.2  
@export var start_delay := 0.00


var plr : player


func _ready() -> void:
	
	plr = get_tree().get_first_node_in_group("Player")
	sprite.hide()
	await get_tree().create_timer(start_delay).timeout
	attack_loop()
	#boss = get_tree().get_first_node_in_group("Boss")
	
	#area.body_entered.connect(on_body_entered)
	#area.body_exited.connect(on_body_exited)

func attack_loop():
	while is_inside_tree():
		await get_tree().create_timer(attack_interval).timeout
		if plr == null or plr.is_dead:
			continue
		await do_attack()

	
func do_attack():
	sprite.show()
	if sprite:
		sprite.modulate = Color(1, 0.5, 0.5)
	sprite.play("before_attack")
	await get_tree().create_timer(windup_time).timeout

	if sprite:
		sprite.modulate = Color.WHITE
	is_attacking = true
	did_hit = false
	sprite.play("on_attack")
	await get_tree().create_timer(hit_time).timeout
	sprite.hide()
	is_attacking = false
	
	
func _process(delta: float) -> void:
	
	if not is_attacking or did_hit:
		return
	if plr == null or plr.is_dead:
		return
	if area.overlaps_body(plr):
		did_hit = true
		plr.die()

	
	
	
#func on_body_entered(body : Node2D):
	#if body.is_in_group("Player"):
		#is_player_in = true
	#
#func on_body_exited(body : Node2D):
	#if body.is_in_group("Player"):
		#is_player_in = false
#
#func did_attack_hit(body : Node2D):
	#if is_player_in and is_attacking:
		#did_hit = true
	#
#func attack1():
	#is_attacking = true
	#
