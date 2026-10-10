extends Camera2D


@export var cam_left_limit : float
@export var cam_right_limit : float
@export var cam_top_limit : float
@export var cam_bottom_limit : float

func _ready() -> void:
	self.limit_left = cam_left_limit
	self.limit_right = cam_right_limit
	self.limit_top = cam_top_limit
	self.limit_bottom = cam_bottom_limit
