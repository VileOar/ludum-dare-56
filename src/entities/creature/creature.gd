extends CharacterBody2D
class_name Creature

## signal emited when this creature gets infected
@warning_ignore("unused_signal")
signal got_infected(position)

@onready var controller: BaseController = %Controller
@onready var _shape: CollisionShape2D = %CollisionShape2D


var _is_infected = false


func _ready() -> void:
	GameData.creature_spawn(_is_infected)


## this function is to set creature to dying sequence (which also emits signals and game logic)
func die():
	controller.replace_state("DeathState")


## actually remove node from tree, should never be used by nodes external to this subtree
func destroy():
	GameData.creature_removed(_is_infected)
	queue_free()


func set_infected(infected: bool):
	_is_infected = infected
		

func get_infected() -> bool:
	return _is_infected


func enable_collision(en = true):
	_shape.set_deferred("disabled", !en)
