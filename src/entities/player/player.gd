extends Node2D
class_name Player

@export var _stomp_scene: PackedScene

const STARTUP_DURATION: float = 0.2 ## (sec) time it takes for startup animation
const MAX_RADIUS: int = 128

@onready var _detector: Area2D = %Detector
@onready var _arrow: Polygon2D = %Arrow

var _radius: int = 0

var _tween

var _pressing = false


func _process(_delta: float) -> void:
	queue_redraw()
	
	_arrow.rotation = Vector2.RIGHT.direction_to(get_local_mouse_position()).angle()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1"):
		show()
		global_position = get_global_mouse_position()
		_tween = get_tree().create_tween()
		_radius = 0
		_tween.tween_property(self, "_radius", MAX_RADIUS, STARTUP_DURATION)
		_pressing = true
	elif event.is_action_released("mouse1") and _pressing:
		_send_rush()
		hide()
		_radius = 0
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


func _draw() -> void:
	var color = Color.YELLOW
	color.a = 0.3
	draw_circle(Vector2.ZERO, _radius, color)
