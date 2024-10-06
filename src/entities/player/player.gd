extends Node2D
class_name Player

@export var _stomp_scene: PackedScene

const STARTUP_DURATION: float = 0.2 ## (sec) time it takes for startup animation
const MAX_RADIUS: float = 0.51
const MIN_RADIUS: float = 0.2

@onready var _detector: Area2D = %Detector
@onready var _arrow: Polygon2D = %Arrow

var _radius: float = MIN_RADIUS
var _tween
var _pressing = false
var _dotted_circle_speed: float = 1.0


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
		_execute_stomp()


func _send_rush():
	AudioManager.play_audio("Throw")
	for creature in _detector.get_overlapping_bodies():
		creature.controller.rush_towards(Vector2.from_angle(_arrow.rotation))


func _execute_stomp():
	AudioManager.play_audio("Stomp")
	var stomp = _stomp_scene.instantiate()
	stomp.position = get_global_mouse_position()
	get_parent().add_child(stomp)
