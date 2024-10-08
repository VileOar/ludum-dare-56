extends BaseController
class_name HealthyController


## callback for when an infection is detected nearby
func _on_infected_nearby(position):
	replace_state("PanicState")
	get_node("PanicState").set_source_position(position)


func _on_detector_body_entered(other: Node2D) -> void:
	if other != body:
		other.got_infected.connect(_on_infected_nearby)


func _on_detector_body_exited(other: Node2D) -> void:
	if other != body:
		other.got_infected.disconnect(_on_infected_nearby)


func _on_hurtbox_body_entered(_other: Node2D) -> void:
	AudioManager.play_audio("Infect")
	body.got_infected.emit(body.position)
	body.destroy()
	var pos = body.position
	Locator.factory_creature.spawn_creature(pos, true)
	for _i in Global.INFECTED_SPAWN_ADDITIONAL:
		Locator.factory_creature.spawn_creature(pos + 64 * Vector2.from_angle(randf() * 2 * PI), true)
