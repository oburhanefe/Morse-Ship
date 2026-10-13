class_name movement_comp
extends Node

@export var speed = Vector2.ZERO
var dir = Vector2.ZERO 

func move(body:CharacterBody2D):
	body.velocity = speed * dir
	body.move_and_slide()
