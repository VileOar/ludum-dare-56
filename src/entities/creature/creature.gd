extends CharacterBody2D
class_name Creature

## signal emited when this creature gets infected
@warning_ignore("unused_signal")
signal got_infected(position)

@onready var controller: BaseController = %Controller


func die():
	queue_free()
