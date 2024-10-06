extends BaseController
class_name InfectedController

const COOLDOWN = 1.0


func _ready() -> void:
	super._ready()
	
	# wait for a bit before being able to infect
	body.set_collision_layer_value(4, false)
	await get_tree().create_timer(COOLDOWN).timeout
	body.set_collision_layer_value(4, true)
	
	set_can_cross_gate(true)


## whenever a new state is deactivated, check detector's overlapping bodies and, if any, go to chase
func _on_state_activated(state: Variant) -> void:
	if state == "ChaseState":
		return
	
	var others = detector.get_overlapping_bodies()
	if others.size() > 0:
		replace_state("ChaseState")
		get_node("ChaseState").set_target(others[0])
