class_name Boss

extends Node2D

signal healt_changed(current: float, max: float)
signal died

@export var max_can := 100.0
@export var area : Area2D
@export var sprite : AnimatedSprite2D
@export var hit_cd := 8.50
@export var outline : ShaderMaterial
@export var plr : player
@export_range(0.0, 1.0) var stun_dmg_ratio := 0.25 
@onready var hp_bar: Label = $"../Label2"

var healt : float
var mouse_ustunde_mi = false
var can_be_hit = true
var accessed := false
var cmd : String
func _ready() -> void:
	if outline:
		outline = outline.duplicate()
	sprite.material = outline
	add_to_group("Boss")
	healt = max_can
	area.mouse_entered.connect(func(): mouse_ustunde_mi = true)
	area.mouse_exited.connect(func(): mouse_ustunde_mi = false)
	healt_changed.emit(healt, max_can)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Delete"):
		accessed = false
		plr.current_boss = null
	if Input.is_action_just_pressed("click") and mouse_ustunde_mi:
		accessed = true
		plr.current_boss = self

	if accessed:
		outline.set_shader_parameter("outline_color", Color.RED)
	else:
		outline.set_shader_parameter("outline_color", Color.BLACK)
		
	if accessed and plr.current_boss == self:
		var current_code = plr.decipher.build_command()
		if current_code in plr.decipher.valid_commands and not current_code.is_empty():
			take_hit()
			plr.decipher.command.clear()
			plr.inp.label.text = ""

func take_hit():
	if not can_be_hit or healt <= 0.0:
		return
	can_be_hit = false
	healt = max(healt - max_can * stun_dmg_ratio, 0.0)
	healt_changed.emit(healt, max_can)
	hp_bar.text = hp_bar.text.left(-1)
	
	var tw := create_tween()
	tw.tween_property(sprite, "self_modulate", Color.RED, 0.2)
	tw.tween_property(sprite, "self_modulate", Color.WHITE, 0.4)
	if healt <= 0:
		died.emit()
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/the_end.tscn")
		queue_free()
		return

	await get_tree().create_timer(hit_cd).timeout
	can_be_hit = true
	print(healt)
