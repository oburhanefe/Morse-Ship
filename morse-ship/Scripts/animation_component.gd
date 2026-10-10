class_name anim_comp
extends Node


func update_anim(anim_player : AnimationPlayer, move_dir : Vector2):
	match move_dir:
		Vector2.ZERO:
			anim_player.play("idle")
		Vector2.RIGHT:
			pass
		Vector2.LEFT:
			pass
		Vector2.UP:
			pass
		Vector2.DOWN:
			pass
