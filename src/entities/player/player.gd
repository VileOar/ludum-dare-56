extends Node2D
class_name Player

@export var _stomp_scene: PackedScene
@export var COOLDOWN_COLOUR: Color = Color(Color.RED, 0.6)

const STARTUP_DURATION: float = 0.2 ## (sec) time it takes for startup animation
const STOMP_COOLDOWN: float = 2.0
const MAX_RADIUS: float = 0.51
const MIN_RADIUS: float = 0.15

const RADIUS_STEP: float = 0.04

@onready var _detector: Area2D = %Detector
@onready var _arrow: Polygon2D = %Arrow
@onready var _stomp_timer: Timer = %StompTimer
@onready var _detector_shape: CollisionShape2D = %CollisionShape2D


var _radius: float = MIN_RADIUS
var _can_stomp: bool = true
var _pressing = false
var _dotted_circle_speed: float = 1.0


func _ready():
	_stomp_timer.wait_time = STOMP_COOLDOWN
	_stomp_timer.timeout.connect(_end_stomp_cooldown)


func _process(_delta: float) -> void:
	if !_pressing:
		global_position = get_global_mouse_position()
	%DottedCircle.rotation += _dotted_circle_speed * _delta 
	%DottedCircle.scale.x = _radius
	%DottedCircle.scale.y = _radius
	
	_arrow.scale = Vector2.ONE * _radius
	
	_detector_shape.scale = Vector2.ONE * _radius
	
	%FullCircle.scale.x = _radius
	%FullCircle.scale.y = _radius
	_arrow.rotation = Vector2.RIGHT.direction_to(get_local_mouse_position()).angle()
	
	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1"):
		%HideElement.show()
		_pressing = true
	elif event.is_action_released("mouse1") and _pressing:
		_send_rush()
		%HideElement.hide()
		_pressing = false
	elif event.is_action_pressed("mouse2"):
		if _can_stomp:
			_execute_stomp()
	elif event.is_action_pressed("wheel_up"):
		_radius = min(_radius + RADIUS_STEP, MAX_RADIUS)
	elif event.is_action_pressed("wheel_down"):
		_radius = max(_radius - RADIUS_STEP, MIN_RADIUS)


func _send_rush():
	AudioManager.play_audio("Throw")
	for creature in _detector.get_overlapping_bodies():
		creature.controller.rush_towards(Vector2.from_angle(_arrow.rotation))


func _execute_stomp():
	var stomp = _stomp_scene.instantiate()
	stomp.set_init_pos(get_global_mouse_position())
	get_parent().add_child(stomp)

	_can_stomp = false
	_stomp_timer.start()


func _end_stomp_cooldown():
	_can_stomp = true


func _draw() -> void:
	if _stomp_timer.time_left > 0:
		var segment_portion = _stomp_timer.time_left*360.0/STOMP_COOLDOWN
		draw_circle_arc_poly(Vector2.ZERO, (_radius/2)*%FullCircle.texture.get_width(), -segment_portion, -360, COOLDOWN_COLOUR)


func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])
	
	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
