extends Node2D

@export var stopmDmg: float = 100

signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	hit.emit()
	$CollisionShape2D.set_deferred("disable", true)
