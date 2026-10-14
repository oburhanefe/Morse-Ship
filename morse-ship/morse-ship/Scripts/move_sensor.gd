class_name Bot
extends CharacterBody2D

@onready var anim_comp = $anim_comp
@export var area : Area2D
@export var move_comp : movement_comp
@export var nav : nav_comp
@export var drone_sprite : AnimatedSprite2D

var look_dir : Vector2
var plr : player


var code : String 
var mouse_ustunde_mi = false

func _ready() -> void:
	plr = get_tree().get_first_node_in_group("Player")
	nav.nav_agent.velocity_computed.connect(_on_velocity_computed)
	area.mouse_entered.connect(func(): mouse_ustunde_mi = true)
	area.mouse_exited.connect(func(): mouse_ustunde_mi = false)

func _physics_process(_delta: float) -> void:
	nav.make_path()
	var next_pos = nav.nav_agent.get_next_path_position()
	move_comp.dir = global_position.direction_to(next_pos)
	if nav.plr.velocity != Vector2.ZERO:
		move_comp.move(self)
		
	if not move_comp.dir == Vector2.ZERO:
		look_dir = move_comp.dir

	anim_comp.update_anim(drone_sprite, move_comp.dir, look_dir)

func _on_velocity_computed(safe_speed : Vector2):
	self.velocity = safe_speed

	
