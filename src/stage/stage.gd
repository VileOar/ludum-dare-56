extends Node2D
class_name Stage

@export var healthy_scene: PackedScene
@export var infected_scene: PackedScene

@onready var creatures: Node = %Creatures
@onready var _spawn_area: TileMapLayer = %SpawnArea



func _ready() -> void:
	Locator.factory_creature = self
	
	var spawn_tiles = _spawn_area.get_used_cells()
	
	for i in Global.INITIAL_CREATURES:
		var infected = i >= Global.INITIAL_CREATURES - Global.INITIAL_INFECTED
		
		var ix = randi() % spawn_tiles.size()
		var cell = spawn_tiles[ix] as Vector2
		var cellsize = (_spawn_area.tile_set.tile_size as Vector2) * _spawn_area.scale
		cell *= cellsize
		
		#var pos = Vector2(randf_range(rect.position.x + 64, rect.end.x - 64), randf_range(rect.position.y + 64, rect.end.y - 64))
		var pos = cell + Vector2(randf() * cellsize.x, randf() * cellsize.y)
		spawn_creature(pos, infected)
	
	GameData.start_timer()
	Signals.toplevel_ready.emit()


func spawn_creature(pos: Vector2, infected: bool = true) -> Creature:
	var scene = infected_scene if infected else healthy_scene
	var new_creature = scene.instantiate() as Creature
	new_creature.position = pos
	new_creature.set_infected(infected)
	creatures.call_deferred("add_child", new_creature)
	
	return new_creature
