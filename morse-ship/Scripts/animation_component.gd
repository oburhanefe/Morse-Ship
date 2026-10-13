class_name anim_comp
extends Node

var step_frame: int = 0
var last_frame: int = -1

func update_anim(anim_sprite : AnimatedSprite2D, move_dir : Vector2, look_dir : Vector2, step_audio : AudioStreamPlayer2D = null):
	
	if move_dir != Vector2.ZERO:
		if move_dir.x != 0:
			anim_sprite.play("walk_sides")
			anim_sprite.flip_h = move_dir.x <0
		elif move_dir.y < 0:
			anim_sprite.play("walk_up")
			anim_sprite.flip_h = false
		elif move_dir.y > 0:
			anim_sprite.play("walk_down")
			anim_sprite.flip_h = false
	else:
		if look_dir.x != 0:
			anim_sprite.play("idle_sides")
		elif look_dir.y == -1:
			anim_sprite.play("idle_up")
		elif look_dir.y == 1:
			anim_sprite.play("idle_down")
	if step_audio:
		if move_dir != Vector2.ZERO:
			
			if anim_sprite.frame != last_frame:
				last_frame = anim_sprite.frame
				step_frame += 1
				if step_frame >= 4:
					step_frame = 0
					step_audio.stop()
					step_audio.play()
		else:
			step_frame = 0
			last_frame = -1
