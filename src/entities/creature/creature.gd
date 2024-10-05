extends CharacterBody2D
class_name Creature

## signal emited when this creature gets infected
@warning_ignore("unused_signal")
signal got_infected(position)

@onready var controller: BaseController = %Controller

var _is_infected = false


func die():
	queue_free()


func set_infected(infected: bool):
	_is_infected = infected


func get_infected() -> bool:
	return _is_infected
