extends Node2D


@export var scene3d: CityScene

const MARGIN_RATE = 10

var screen_size
var screen_size_pan_margins

@export var pan_speed = 10
var cam_move_direction = Vector2.ZERO
	
var mouse_pos = Vector2.ZERO
var mouse_border = {"top": false, "bottom": false, "left": false, "right": false}
var _allow_mouse_cam = false

@onready var cam_anchor: Node2D = %CameraAnchor
@onready var cam: Camera2D = %MainCam


# Screen shake vars
var trauma := 0.0

@export var trauma_reduction_rate := 1.6
@export var max_x := 60
@export var max_y := 60

@export var noise : FastNoiseLite
@export var noise_speed := 700

var time := 0.0



func _ready():
	screen_size = get_viewport().get_visible_rect().size
	screen_size_pan_margins = screen_size.x / MARGIN_RATE

	Signals.screen_shake.connect(_add_noise)


func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate * trauma_reduction_rate, 0.0)
	
	cam.position.x = max_x * trauma * trauma * _get_noise_from_seed(0)
	cam.position.y = max_y * trauma * trauma * _get_noise_from_seed(1)


func _physics_process(_delta: float) -> void:

	cam_move_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	if _allow_mouse_cam:
		mouse_pos = get_viewport().get_mouse_position()

		mouse_border["top"] = mouse_pos.y < screen_size_pan_margins
		mouse_border["bottom"] = mouse_pos.y > screen_size.y - screen_size_pan_margins
		mouse_border["left"] = mouse_pos.x < screen_size_pan_margins
		mouse_border["right"] = mouse_pos.x > screen_size.x - screen_size_pan_margins

		if mouse_border["right"]:
			cam_move_direction.x += 1
		elif mouse_border["left"]:
			cam_move_direction.x -= 1

		if mouse_border["bottom"]:
			cam_move_direction.y += 1
		elif mouse_border["top"]:
			cam_move_direction.y -= 1

	cam_anchor.position += (cam_move_direction.normalized() * pan_speed)
	scene3d.set_cam_position(Vector3(cam_anchor.position.x, 0, cam_anchor.position.y)/100)


func _add_noise(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)


func _get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)
