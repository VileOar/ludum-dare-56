extends Node2D


@export var creature_scene: PackedScene

const CREATURE_NUM = 10

@onready var creatures: Node = %Creatures


func _ready() -> void:
	var rect = get_viewport_rect()
	for i in CREATURE_NUM:
		var new_creature = creature_scene.instantiate()
		new_creature.position = Vector2(randf_range(rect.position.x + 64, rect.end.x - 64), randf_range(rect.position.y + 64, rect.end.y - 64))
		creatures.add_child(new_creature)
