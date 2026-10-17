extends CharacterBody2D

@onready var label = $Label
@onready var anim = $AnimatedSprite2D

var step = 0
var waiting = false
var can_leave = false

func _ready():
	label.text = "Hey you, finally awake."
	waiting = true
	step = 1
	
func screenshake():
	var camera = get_viewport().get_camera_2d()
	
	var tween = create_tween()
	
	for i in int(1 / 0.05):
		var random_shake = Vector2(randf_range(-4, 4), randf_range(-4, 4))
		tween.tween_property(camera, "offset", random_shake, 0.05)
	
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.05)

func _process(delta: float) -> void:
	if (Input.is_action_pressed("click") and waiting and step == 1):
		waiting = false
		label.text = "Welcome to our space station and congratulations on your new job."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		
	if (Input.is_action_pressed("click") and waiting and step == 2):
		waiting = false
		label.text = "We have a perfect system here that is fully automated by robots."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		
	if (Input.is_action_pressed("click") and waiting and step == 3):
		waiting = false
		label.text = "You can control the robots with the remote we gave you."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		
	if (Input.is_action_pressed("click") and waiting and step == 4):
		waiting = false
		label.text = "The remote works with short and long presses, just like Morse code."
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		
	if (Input.is_action_pressed("click") and waiting and step == 5):
		waiting = false
		screenshake()
		await get_tree().create_timer(0.3).timeout
		label.text = "What was that!?"
		await get_tree().create_timer(1.0).timeout
		step += 1
		waiting = true
		
	if (Input.is_action_pressed("click") and waiting and step == 6):
		waiting = false
		label.text = ""
		var tween = create_tween()
		anim.play("walk_up")
		tween.tween_property(self, "position:y", position.y - 275, 2)
		await tween.finished
		hide()
		can_leave = true
