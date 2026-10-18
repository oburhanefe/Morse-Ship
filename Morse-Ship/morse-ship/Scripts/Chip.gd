class_name Chip
extends Node2D

@onready var unlock_area = $UnlockChip
@onready var sprite = $AnimatedSprite2D
@export var unlocked_code : String
@export var Type : ChipTypes


enum ChipTypes{
	Blue,
	Yellow
}

func _ready() -> void:
	unlock_area.body_entered.connect(_on_unlock)
	match Type:
		ChipTypes.Blue:
			sprite.play("blue")
		ChipTypes.Yellow:
			sprite.play("yellow")

func _on_unlock(body : Node2D):
	if body.is_in_group("Player"):
		SaveManager.unlocked_commands.append(unlocked_code)
