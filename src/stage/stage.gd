extends Node2D


@export var healthy_scene: PackedScene
@export var infected_scene: PackedScene

const CREATURE_NUM = 10

@onready var creatures: Node = %Creatures


func _ready() -> void:
	Signals.spawn_infected_request.connect(_spawn_creature)
	
	var rect = get_viewport_rect()
	for i in CREATURE_NUM:
		var infected = i == CREATURE_NUM - 1
		var pos = Vector2(randf_range(rect.position.x + 64, rect.end.x - 64), randf_range(rect.position.y + 64, rect.end.y - 64))
		_spawn_creature(pos, infected)
	
	Signals.toplevel_ready.emit()


func _spawn_creature(pos: Vector2, infected: bool = true):
	var scene = infected_scene if infected else healthy_scene
	var new_creature = scene.instantiate() as Creature
	new_creature.position = pos
	new_creature.set_infected(infected)
	creatures.call_deferred("add_child", new_creature)
