extends CharacterBody2D



@export var move_comp : movement_comp
@export var nav : nav_comp


func _physics_process(_delta: float) -> void:
	nav.make_path()
	var next_pos = nav.nav_agent.get_next_path_position()
	move_comp.dir = global_position.direction_to(next_pos)
	if nav.plr.velocity != Vector2.ZERO:
		move_comp.move(self)
