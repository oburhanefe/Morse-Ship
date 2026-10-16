class_name Bot
extends CharacterBody2D

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var anim_comp = $anim_comp
@export var area : Area2D
@export var move_comp : movement_comp
@export var drone_sprite : AnimatedSprite2D
@export var waypoints : Array[Node2D]
@export var timer : Timer

var look_dir : Vector2
var plr : player


var code : String 
var mouse_ustunde_mi = false

func _ready() -> void:

	timer.timeout.connect(recalc)
	plr = get_tree().get_first_node_in_group("Player")
	nav.velocity_computed.connect(_on_velocity_computed)
	area.mouse_entered.connect(func(): mouse_ustunde_mi = true)
	area.mouse_exited.connect(func(): mouse_ustunde_mi = false)

func _physics_process(_delta: float) -> void:

	if nav.is_navigation_finished():
		move_comp.dir = Vector2.ZERO
		velocity = Vector2.ZERO
		move_comp.move(self)
		return
	
	var  next_path_pos := nav.get_next_path_position()
	var desired_dir = global_position.direction_to(next_path_pos)
	move_comp.dir = desired_dir
	var desired_velocity = desired_dir * 20
	#if nav.plr.velocity != Vector2.ZERO
	move_comp.move(self)
	
	if nav.avoidance_enabled:
		nav.set_velocity(desired_velocity)
	else:
		self.velocity = desired_velocity


	if not move_comp.dir == Vector2.ZERO:
		look_dir = move_comp.dir

	anim_comp.update_anim(drone_sprite, move_comp.dir, look_dir)

func _on_velocity_computed(safe_speed : Vector2):
	self.velocity = safe_speed
	
	
func recalc():
	var map := nav.get_navigation_map()
	var snapped := NavigationServer2D.map_get_closest_point(map, plr.global_position)
	if nav.target_position.distance_to(snapped) > 8.0:
		nav.target_position = snapped
