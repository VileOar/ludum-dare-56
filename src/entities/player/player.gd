extends Node2D
class_name Player

@export var _stomp_scene: PackedScene

const STARTUP_DURATION: float = 0.2 ## (sec) time it takes for startup animation
const STOMP_COOLDOWN: float = 4.0
const MAX_RADIUS: float = 0.51
const MIN_RADIUS: float = 0.2

@onready var _detector: Area2D = %Detector
@onready var _arrow: Polygon2D = %Arrow
@onready var _stomp_timer: Timer = %StompTimer


var _radius: float = MIN_RADIUS
var _tween
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
	
	%FullCircle.scale.x = _radius
	%FullCircle.scale.y = _radius
	_arrow.rotation = Vector2.RIGHT.direction_to(get_local_mouse_position()).angle()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1"):
		%HideElement.show()
		_tween = get_tree().create_tween()
		_radius = MIN_RADIUS
		_tween.tween_property(self, "_radius", MAX_RADIUS, STARTUP_DURATION)
		_pressing = true
	elif event.is_action_released("mouse1") and _pressing:
		_send_rush()
		%HideElement.hide()
		_radius = MIN_RADIUS
		if _tween:
			_tween.kill()
		_pressing = false
	elif event.is_action_pressed("mouse2"):
		if _can_stomp:
			_execute_stomp()


func _send_rush():
	AudioManager.play_audio("Throw")
	for creature in _detector.get_overlapping_bodies():
		creature.controller.rush_towards(Vector2.from_angle(_arrow.rotation))


func _execute_stomp():
	AudioManager.play_audio("Stomp")
	var stomp = _stomp_scene.instantiate()
	stomp.set_init_pos(get_global_mouse_position())
	get_parent().add_child(stomp)

	_can_stomp = false
	_stomp_timer.start()


func _end_stomp_cooldown():
	_can_stomp = true


func _draw() -> void:
	var color = Color.YELLOW
	color.a = 0.3
	draw_circle(Vector2.ZERO, _radius, color)
