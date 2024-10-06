extends Node3D
class_name CityScene

@export var building_asset: PackedScene

@onready var cam : Camera3D = %Camera3D
@onready var cam_anchor: Node3D = %CamAnchor
@onready var buildings: Node3D = %Buildings


func _ready():
	Locator.factory_assets3d = self


## this script is the proxy between 3d and 2d
func spawn_3d_object(pos2d: Vector2) -> Node3D:
	var building = building_asset.instantiate()
	building.position = Vector3(pos2d.x, 0, pos2d.y) / 100.0
	buildings.call_deferred("add_child", building)
	
	return building


func set_cam_position(pos: Vector3):
	cam_anchor.position = pos
