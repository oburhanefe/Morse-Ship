class_name box_platform

extends Area2D

@export var specific_box : Node2D

signal toggled(is_on : bool)

var box_on_top := false
var is_on := false

func _ready():
	self.body_entered.connect(on_body_entered)
	self.body_exited.connect(on_body_exited)


func on_body_entered(body : Node2D):
	if body == specific_box:
		box_on_top = true
		is_on = true
		toggled.emit(is_on)
		print(box_on_top)


func on_body_exited(body : Node2D):
	if body == specific_box:
		box_on_top = false
		is_on = false
		toggled.emit(is_on)
		print(box_on_top)
