extends Node3D
class_name IngameBuilding

@onready var building: Node3D = %Building
@onready var rubble: Node3D = %Rubble
@onready var _collision_poly: CollisionPolygon3D = %CollisionPolygon3D


func ravage_building():
	building.visible = false
	rubble.visible = true


func get_polygon() -> PackedVector2Array:
	return _collision_poly.polygon if _collision_poly else PackedVector2Array([])
