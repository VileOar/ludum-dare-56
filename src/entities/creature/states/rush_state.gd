extends WanderState
class_name RushState

var _dir_changed = false ## whether direction was already changed

var _can_cross_mem: bool


func activate():
	super.activate()
	_dir_changed = false
	_can_cross_mem = _controller.get_can_cross_gate()
	_controller.set_can_cross_gate(true)
	_controller.sprite.play("rush")


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	if _collision_info:
		var other = _collision_info.get_collider()
		if other is Creature:
			other.controller.rush_towards(-_mov_dir)


func deactivate():
	super.deactivate()
	_controller.set_can_cross_gate(_can_cross_mem)


func allow_next_state(state: String) -> bool:
	return !_moving or state in _controller.whitelist_states


func set_rush_direction(direction: Vector2):
	if _dir_changed:
		return
	_mov_dir = direction
	_dir_changed = true
