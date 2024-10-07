extends StaticBody2D
class_name StageHazard

var _asset: Node3D

const SPAWN_OFFSET = 96

@export var obj_type: int = 0

@onready var _collision_poly: CollisionPolygon2D = %CollisionPolygon2D

var unbroken = true


func _ready() -> void:
	await Signals.toplevel_ready
	_asset = Locator.factory_assets3d.spawn_3d_object(position, rotation, obj_type)
	while !_asset.is_node_ready():
		await _asset.ready
	if _collision_poly:
		var polygon = _asset.get_polygon()
		for i in polygon.size():
			polygon[i] *= 100
		_collision_poly.polygon = polygon


func stomped():
	# TODO: do something else

	if unbroken:
		AudioManager.play_audio("Demolition")
		_asset.ravage_building()
		unbroken = false
		_spawn_creatures()


func _spawn_creatures():
	var num = Global.rng.randi_range(Global.MIN_CREATURES_PER_BUILDING, Global.MAX_CREATURES_PER_BUILDING)
	for i in num:
		var infected = randf() < Global.BUILDING_INFECTED_CHANCE
		var angle = PI*randf() + (PI if infected else 0.0)
		var pos = position + Vector2.from_angle(angle) * SPAWN_OFFSET
		var new_creature: Creature = Locator.factory_creature.spawn_creature(pos, infected) as Creature
		while !new_creature.is_node_ready():
			await new_creature.ready
		
		new_creature.controller.rush_towards(position.direction_to(new_creature.position))
