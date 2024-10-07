extends WanderState
class_name PanicState

const CHANGE_DIRECTION_CHANCE: float = 0.1

var _source_position: Vector2


func activate():
	AudioManager.play_audio("Scream")
	super.activate()
	# move away from source position
	var dir = _source_position.direction_to(_controller.body.position)
	_mov_dir = dir.rotated(randf_range(-PI/4.0, PI/4.0))
	_controller.sprite.play("panic")


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if randf() < CHANGE_DIRECTION_CHANCE:
		_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector


func allow_next_state(_state: String) -> bool:
	return true#return !_moving or state in _controller.whitelist_states


func set_source_position(pos: Vector2):
	_source_position = pos
