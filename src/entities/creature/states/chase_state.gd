extends StackState
class_name ChaseState

@export var SPEED: int = 60 # px/sec
@export var SPEED_MULTIPLIER = 1.0
@export var GIVEUP_RANGE = 512

@onready var _controller: BaseController = _fsm as BaseController

var _target: Creature # the entity to move towards

var _aggroing = true


func acivate():
	_aggroing = true
	_controller.sprite.play("chase")


func _physics_process(delta: float) -> void:
	var giveup = false
	
	if is_instance_valid(_target):
		var diff_vector = _target.position - _controller.body.position
		_controller.body.move_and_collide(SPEED_MULTIPLIER * SPEED * diff_vector.normalized() * delta)
		_controller.set_hdir(1 if diff_vector.x >= 0 else -1)
		
		# dunno why this is needed, but oh well
		if _controller.sprite.animation != "chase":
			_controller.sprite.play("chase")
		
		# if a certain distance from target, give up
		if diff_vector.length() >= GIVEUP_RANGE:
			giveup = true
	else: # stop chasing if target was destroyed (for instance, by being hit by this creature who was chasing it)
		giveup = true
		_target = null # cleanup, not really necessary
	
	if giveup:
		_aggroing = false # disable aggroing to be able to change state
		_controller.replace_state("IdleState")


func allow_next_state(state: String) -> bool:
	return !_aggroing or state in _controller.whitelist_states


func set_target(target: Creature):
	_target = target
