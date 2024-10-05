## state for walking for a bit and stopping
extends StackState
class_name WanderState

const SPEED: int = 60 # px/sec
const WANDER_DURATION: float = 2.0 # sec
const REPEAT_CHANCE: float = 0.5 # chance to repeat wander state on timer end

@onready var _controller: BaseController = _fsm as BaseController

var _mov_dir: Vector2 = Vector2.RIGHT


func activate():
	get_tree().create_timer(WANDER_DURATION).timeout.connect(_on_timer_timeout)
	_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector


func _physics_process(delta: float) -> void:
	_controller.body.move_and_collide(SPEED * _mov_dir * delta)


func _on_timer_timeout() -> void:
	if !can_process():
		return
	print_debug(process_mode)
	# has chance to move again (making it move in a different direction) or go to idle
	var next_state = "WanderState" if randf() < REPEAT_CHANCE else "IdleState"
	_controller.replace_state(next_state)
