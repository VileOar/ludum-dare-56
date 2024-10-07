extends Node3D
class_name CityScene

@export var building_assets: Array[PackedScene]

@onready var cam : Camera3D = %Camera3D
@onready var cam_anchor: Node3D = %CamAnchor
@onready var buildings: Node3D = %Buildings


func _ready():
	Locator.factory_assets3d = self


## this script is the proxy between 3d and 2d
func spawn_3d_object(pos2d: Vector2, rot2d: float, obj_type: int) -> IngameBuilding:

	var asset_to_use = building_assets[obj_type]

	var building = asset_to_use.instantiate()
	building.position = Vector3(pos2d.x, 0, pos2d.y) / 100.0
	building.rotation = Vector3(0, -rot2d, 0)
	buildings.call_deferred("add_child", building)
	
	return building


func set_cam_position(pos: Vector3):
	cam_anchor.position = pos
