class_name anim_comp
extends Node


func update_anim(anim_sprite : AnimatedSprite2D, move_dir : Vector2, look_dir : Vector2):
	if move_dir != Vector2.ZERO:
		if move_dir.x != 0:
			anim_sprite.play("idle_sides")
			anim_sprite.flip_h = move_dir.x < 0
		elif move_dir.y < 0:
			anim_sprite.play("idle_up")
			anim_sprite.flip_h = false
		elif move_dir.y > 0:
			anim_sprite.play("idle_down")
			anim_sprite.flip_h = false
	else:
		match look_dir:
			Vector2.RIGHT:
				anim_sprite.play("idle_sides")
				anim_sprite.flip_h = false
			Vector2.LEFT:
				anim_sprite.play("idle_sides")
				anim_sprite.flip_h = true
			Vector2.UP:
				anim_sprite.play("idle_up")
				anim_sprite.flip_h = false
			Vector2.DOWN:
				anim_sprite.play("idle_down")
				anim_sprite.flip_h = false
			_:
				anim_sprite.play("idle_down")
				anim_sprite.flip_h = false
