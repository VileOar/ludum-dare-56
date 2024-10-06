extends WanderState
class_name RushState

var _dir_changed = false ## whether direction was already changed


func activate():
	super.activate()
	_dir_changed = false
	_controller.set_can_cross_gate(true)


func deactivate():
	super.deactivate()
	_controller.set_can_cross_gate(false)


func allow_next_state(state: String) -> bool:
	return !_moving or state in _controller.whitelist_states


func set_rush_direction(direction: Vector2):
	if _dir_changed:
		return
	_mov_dir = direction
	_dir_changed = true
