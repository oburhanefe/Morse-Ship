class_name Chip
extends Node2D

@onready var unlock_area = $UnlockChip
@onready var sprite = $AnimatedSprite2D
@export var unlocked_code : String
@export var Type : ChipTypes
@export var plr : player


enum ChipTypes{
	Slow,
	MadCow
}

func _ready() -> void:
	unlock_area.body_entered.connect(_on_unlock)
	match Type:
		ChipTypes.Slow:
			sprite.play("blue")
			
		ChipTypes.Slow:
			sprite.play("yellow")
			
func _on_unlock(body : Node2D):
	if body.is_in_group("Player"):
		match Type:
			ChipTypes.Slow:
				plr.slow.visible = true
			ChipTypes.MadCow:
				plr.mad_cow.visible = true
		SaveManager.unlocked_commands.append(unlocked_code)
		self.queue_free()
