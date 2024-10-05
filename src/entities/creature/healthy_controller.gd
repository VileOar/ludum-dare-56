extends BaseController
class_name HealthyController


## callback for when an infection is detected nearby
func _on_infected_nearby(position):
	replace_state("PanicState")
	get_node("PanicState").set_source_position(position)


func _on_detector_body_entered(other: Node2D) -> void:
	other.got_infected.connect(_on_infected_nearby)


func _on_detector_body_exited(other: Node2D) -> void:
	other.got_infected.disconnect(_on_infected_nearby)


func _on_hurtbox_body_entered(_other: Node2D) -> void:
	body.got_infected.emit(body.position)
	body.die()
	var pos = body.position
	Signals.spawn_infected_request.emit(pos)
	for _i in Global.INFECTED_SPAWN_ADDITIONAL:
		Signals.spawn_infected_request.emit(pos + 64 * Vector2.from_angle(randf() * 2 * PI))
