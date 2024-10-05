extends WanderState
class_name PanicState

const CHANGE_DIRECTION_CHANCE: float = 0.1

var _source_position: Vector2


func _ready() -> void:
	STATE_DURATION = 3.0
	SPEED_MULTIPLIER = 5.0


func activate():
	super.activate()
	# move away from source position
	var dir = _source_position.direction_to(_controller.body.position)
	_mov_dir = dir.rotated(randf_range(-PI/4.0, PI/4.0))


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if randf() < CHANGE_DIRECTION_CHANCE:
		_mov_dir = Vector2.from_angle(randf() * 2 * PI) # choose random direction vector


func allow_next_state(_state: String) -> bool:
	return !_moving


func set_source_position(pos: Vector2):
	_source_position = pos
