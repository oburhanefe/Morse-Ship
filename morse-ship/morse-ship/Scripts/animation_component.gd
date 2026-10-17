class_name anim_comp
extends Node



var step_frame: int = 0
var last_frame: int = -1

func update_anim(anim_sprite : AnimatedSprite2D, move_dir : Vector2, look_dir : Vector2,
 step_audio : AudioStreamPlayer2D = null):
	
	if move_dir != Vector2.ZERO:
		# Yatay hareketin dikeyden net bir şekilde baskın olması gerekiyor (1.5 kat tolerans)
		if abs(move_dir.x) > abs(move_dir.y) * 1.5:
			anim_sprite.play("walk_sides")
			anim_sprite.flip_h = move_dir.x < 0
			anim_sprite.flip_v = false
		else:
			anim_sprite.flip_h = false
			anim_sprite.flip_v = false
			if move_dir.y < 0:
				anim_sprite.play("walk_up")
			else:
				anim_sprite.play("walk_down")
	else:
		if abs(look_dir.x) > abs(look_dir.y) * 1.5:
			anim_sprite.play("idle_sides")
			anim_sprite.flip_h = look_dir.x < 0
			anim_sprite.flip_v = false
		else:
			anim_sprite.flip_h = false
			anim_sprite.flip_v = false
			if look_dir.y < 0:
				anim_sprite.play("idle_up")
			else:
				anim_sprite.play("idle_down")
				
	if step_audio:
		if move_dir != Vector2.ZERO and not step_audio.playing:
			step_audio.play()
	
	
#	Old version:
#	if move_dir != Vector2.ZERO:
#		if move_dir.x != 0:
#			anim_sprite.play("walk_sides")
#			anim_sprite.flip_h = move_dir.x <0
#		elif move_dir.y < 0:
#			anim_sprite.play("walk_up")
#			anim_sprite.flip_h = false
#		elif move_dir.y > 0:
#			anim_sprite.play("walk_down")
#			anim_sprite.flip_h = false
#	else:
#		if look_dir.x != 0:
#			anim_sprite.play("idle_sides")
#		elif look_dir.y == -1:
#			anim_sprite.play("idle_up")
#		elif look_dir.y == 1:
#			anim_sprite.play("idle_down")
#	if step_audio:
#		if move_dir != Vector2.ZERO and not step_audio.playing:
#			step_audio.play()
