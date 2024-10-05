## base controller for all types of creatures
extends StackStateMachine
class_name BaseController

@onready var body: Creature = get_parent() as Creature

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var detector: Area2D = %Detector

var _can_cross_gate:= false ## whether this creature can cross the gate


func _ready() -> void:
	super._ready()
	push_state("IdleState")


## called externally to force creatures into rush state
func rush_towards(direction: Vector2):
	replace_state("RushState") # must change state FIRST, so it runs the init code first
	get_node("RushState").set_rush_direction(direction)


func set_can_cross_gate(can_cross: bool):
	_can_cross_gate = can_cross
