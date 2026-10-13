extends CharacterBody2D



@export var move_comp : movement_comp
@export var nav : nav_comp
@export var pass_code : PassCode

var code : String 

func _ready() -> void:
	nav.nav_agent.velocity_computed.connect(_on_velocity_computed)
	code = pass_code.generate_code()

func _physics_process(_delta: float) -> void:
	nav.make_path()
	var next_pos = nav.nav_agent.get_next_path_position()
	move_comp.dir = global_position.direction_to(next_pos)
	if nav.plr.velocity != Vector2.ZERO:
		move_comp.move(self)


func _on_velocity_computed(safe_speed : Vector2):
	self.velocity = safe_speed
