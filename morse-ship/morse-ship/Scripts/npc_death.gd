extends CharacterBody2D

@onready var label = $Label
@onready var anim = $AnimatedSprite2D

var step = 0
var waiting = false
var can_leave = false

func _ready():
	anim.play("death")
	label.text = "Oh, this can't be."
	await get_tree().create_timer(4.0).timeout
	waiting = true
	step = 1
	
func _process(delta: float) -> void:
	if (Input.is_action_pressed("click") and waiting and step == 1):
		waiting = false
		label.text = "Robots have gone wild."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
	
	if (Input.is_action_pressed("click") and waiting and step == 2):
		waiting = false
		label.text = "If you want to survive, grab the keys from the computer and botany rooms and insert them into the ship's control panel here."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
	
	if (Input.is_action_pressed("click") and waiting and step == 3):
		waiting = false
		label.text = "There are also some chips that will let you control the robots in the lower rooms."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
	
	if (Input.is_action_pressed("click") and waiting and step == 4):
		waiting = false
		label.text = "Good Luck."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		can_leave = true
