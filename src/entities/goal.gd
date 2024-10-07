extends Area2D
class_name Goal

const CIRCLE_BASE_RADIUS = 96
const CIRCLE_RADIUS_DELTA = 32

@export var cam: CustomCamera

@onready var arrow_anchor: Node2D = %ArrowAnchor

var _onscreen = true
var _cam_rect: Rect2

var _radius = CIRCLE_BASE_RADIUS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_cam_rect = cam.get_map_rect()
	_onscreen = _cam_rect.has_point(global_position)
	
	var time = Time.get_ticks_msec()
	_radius = CIRCLE_BASE_RADIUS + sin(time / 256) * CIRCLE_RADIUS_DELTA
	print(_radius)
	
	queue_redraw()
	print()


func _draw() -> void:
	if _onscreen:
		print("hi")
		draw_circle(Vector2.ZERO, _radius, Color("ff9933"), false, 16)
	
