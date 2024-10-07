## state for walking for a bit and stopping
extends StackState
class_name WanderState

@export var SPEED: int = 60 # px/sec
@export var STATE_DURATION: float = 2.0 # sec
@export var REPEAT_CHANCE: float = 0.5 # chance to repeat wander state on timer end
@export var SPEED_MULTIPLIER = 1.0

@onready var _controller: BaseController = _fsm as BaseController

var _mov_dir: Vector2 = Vector2.RIGHT
var _moving = false # whether still moving

var _collision_info


func activate():
	get_tree().create_timer(STATE_DURATION).timeout.connect(_on_timer_timeout)
	_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector
	_moving = true
	_controller.sprite.play("wander")


func _physics_process(delta: float) -> void:
	_collision_info = _controller.body.move_and_collide(SPEED_MULTIPLIER * SPEED * _mov_dir * delta)
	if _collision_info:
		_mov_dir = _mov_dir.bounce(_collision_info.get_normal())
	_controller.set_hdir(1 if _mov_dir.x >= 0 else -1)


func _on_timer_timeout() -> void:
	if !can_process():
		return
	_moving = false
	# has chance to move again (making it move in a different direction) or go to idle
	var next_state = "WanderState" if randf() < REPEAT_CHANCE else "IdleState"
	_controller.replace_state(next_state)
