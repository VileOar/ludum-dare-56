extends StackState
class_name IdleState

const IDLE_MIN_DURATION: float = 1.0 # sec
const IDLE_MAX_DURATION: float = 3.0 # sec

@onready var _controller: BaseController = _fsm as BaseController

var _mov_dir: Vector2 = Vector2.RIGHT


func activate():
	var dur = randf_range(IDLE_MIN_DURATION, IDLE_MAX_DURATION)
	get_tree().create_timer(dur).timeout.connect(_on_timer_timeout)
	_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector


func _on_timer_timeout() -> void:
	if !can_process():
		return
	_controller.replace_state("WanderState")
