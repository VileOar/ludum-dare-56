extends Area2D
class_name Goal

const CIRCLE_BASE_RADIUS = 96
const CIRCLE_RADIUS_DELTA = 32
const MARGIN = 96

const ARROW_ANIM_DELTA = 56

@export var cam: CustomCamera

@onready var _arrow_anchor: Node2D = %ArrowAnchor

var _onscreen = true
var _cam_rect: Rect2

var _radius = CIRCLE_BASE_RADIUS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_cam_rect = cam.get_map_rect(true)
	_onscreen = _cam_rect.has_point(global_position)
	
	_arrow_anchor.visible = !_onscreen
	
	_arrow_anchor.global_position = global_position
	_arrow_anchor.global_position.x = clamp(_arrow_anchor.global_position.x, _cam_rect.position.x + MARGIN, _cam_rect.end.x - MARGIN)
	_arrow_anchor.global_position.y = clamp(_arrow_anchor.global_position.y, _cam_rect.position.y + MARGIN, _cam_rect.end.y - MARGIN)
	_arrow_anchor.rotation = _arrow_anchor.global_position.direction_to(global_position).angle()
	
	var time = Time.get_ticks_msec()
	_radius = CIRCLE_BASE_RADIUS + sin(int(time / 256.0)) * CIRCLE_RADIUS_DELTA
	
	%Sprite2D.position.x = sin(int(time / 256.0)) * ARROW_ANIM_DELTA
	
	queue_redraw()


func _draw() -> void:
	if _onscreen:
		draw_circle(Vector2.ZERO, _radius, Color("ff9933"), false, 16)
	
