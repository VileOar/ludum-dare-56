extends Area2D
class_name Stomp

const LIFESPAN = 1.2
const COL_ACTIVATION_TIME = 0.4 ## (sec) time it takes to enable stomp collision
const SPAWN_Y_OFFSET = 100
const TWEEN_DURATION = 0.5

var _start_mouse_pos: Vector2 = Vector2.ZERO
var _offscreen_pos: Vector2 = Vector2.ZERO

@onready var _collision: CollisionShape2D = %CollisionShape2D


func _ready() -> void:
	var timer = get_tree().create_timer(LIFESPAN)
	timer.timeout.connect(_on_lifespan_end)

	var col_timer = get_tree().create_timer(COL_ACTIVATION_TIME)
	col_timer.timeout.connect(_activate_col)
	
	var pos_tween = create_tween().set_trans(Tween.TRANS_EXPO)
	pos_tween.tween_property(self, "position", _start_mouse_pos, TWEEN_DURATION)
	pos_tween.tween_property(self, "position", _offscreen_pos, TWEEN_DURATION)
	pos_tween.step_finished.connect(_on_tween_step)

	
func set_init_pos(mouse_pos : Vector2):
	_start_mouse_pos = mouse_pos
	position = Vector2(mouse_pos.x, mouse_pos.y - Global.viewport_size.y - SPAWN_Y_OFFSET)
	_offscreen_pos = position


func _on_body_entered(body: Node2D) -> void:
	if body is Creature:
		body.die()
	elif body is StaticBody2D:
		body.queue_free()


func _on_lifespan_end():
	queue_free()


func _activate_col():
	_collision.disabled = false;


func _on_tween_step(idx:int):
	if idx == 0:
		_collision.disabled = true;
