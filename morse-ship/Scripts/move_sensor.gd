class_name Bot
extends CharacterBody2D


@export var area : Area2D
@export var move_comp : movement_comp
@export var nav : nav_comp


var code : String 
var mouse_ustunde_mi = false

func _ready() -> void:
	plr = get_tree().get_first_node_in_group("Player")
	nav.nav_agent.velocity_computed.connect(_on_velocity_computed)
	code = pass_code.generate_code()
	mouse_entered.connect(func(): mouse_ustunde_mi = true)
	mouse_exited.connect(func(): mouse_ustunde_mi = false)

func _physics_process(_delta: float) -> void:
	nav.make_path()
	var next_pos = nav.nav_agent.get_next_path_position()
	move_comp.dir = global_position.direction_to(next_pos)
	if nav.plr.velocity != Vector2.ZERO:
		move_comp.move(self)
		

func _on_velocity_computed(safe_speed : Vector2):
	self.velocity = safe_speed

	
