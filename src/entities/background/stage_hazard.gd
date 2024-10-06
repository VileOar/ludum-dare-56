extends StaticBody2D
class_name StageHazard

var _asset: Node3D

const SPAWN_OFFSET = 192

var unbroken = true


func _ready() -> void:
	await Signals.toplevel_ready
	Signals.spawn_3d_asset.emit(position, self)


func set_asset(asset: Node3D):
	_asset = asset


func stomped():
	# TODO: do something else
	AudioManager.play_audio("Demolition")

	if unbroken:
		unbroken = false
		_spawn_creatures()


func _spawn_creatures():
	var num = Global.rng.randi_range(Global.MIN_CREATURES_PER_BUILDING, Global.MAX_CREATURES_PER_BUILDING)
	for i in num:
		var infected = randf() < Global.BUILDING_INFECTED_CHANCE
		var angle = PI*randf() + (PI if infected else 0.0)
		var pos = position + Vector2.from_angle(angle) * SPAWN_OFFSET
		Signals.spawn_creature_request.emit(pos, infected)
