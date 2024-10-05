extends StackState
class_name IdleState

const IDLE_DURATION: float = 3.0 # sec

@onready var _controller: BaseController = _fsm as BaseController

var _mov_dir: Vector2 = Vector2.RIGHT


func activate():
	get_tree().create_timer(IDLE_DURATION).timeout.connect(_on_timer_timeout)
	_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector


func _on_timer_timeout() -> void:
	if !can_process():
		return
	print_debug(process_mode)
	_controller.replace_state("WanderState")
