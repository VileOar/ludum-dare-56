extends WanderState
class_name RushState

var _dir_changed = false ## whether direction was already changed


func _ready() -> void:
	SPEED_MULTIPLIER = 3.0


func activate():
	super.activate()
	_dir_changed = false
	_controller.set_can_cross_gate(true)


func deactivate():
	super.deactivate()
	_controller.set_can_cross_gate(false)


func allow_next_state(_state: String) -> bool:
	return !_moving


func set_rush_direction(direction: Vector2):
	if _dir_changed:
		return
	_mov_dir = direction
	_dir_changed = true
