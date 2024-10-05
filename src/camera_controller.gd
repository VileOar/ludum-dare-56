extends Node2D


var screen_size
var screen_size_pan_margins
var margin_rate = 10

var pan_speed = 10

var mouse_pos = Vector2.ZERO
var cam_move_direction = Vector2.ZERO
var mouse_border = {"top": false, "bottom": false, "left": false, "right": false}

@onready var cam_anchor : Node2D = %CameraAnchor


func _ready():
	screen_size = get_viewport().get_visible_rect().size
	screen_size_pan_margins = screen_size.x / margin_rate


func _physics_process(_delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	cam_move_direction = Vector2.ZERO

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

	Signals.cam_has_moved.emit(cam_move_direction)
	cam_anchor.position = cam_anchor.position + cam_move_direction.normalized() * 10
