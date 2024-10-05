extends WanderState
class_name RushState


func _ready() -> void:
	SPEED_MULTIPLIER = 3.0


func activate():
	super.activate()
	_controller.set_can_cross_gate(true)


func deactivate():
	super.deactivate()
	_controller.set_can_cross_gate(false)


func set_rush_direction(direction: Vector2):
	_mov_dir = direction
