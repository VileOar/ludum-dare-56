extends Node3D
class_name CityScene

@export var building_asset1: PackedScene
@export var building_asset2: PackedScene
@export var building_asset3: PackedScene
@export var building_asset4: PackedScene
@export var building_asset5: PackedScene

@onready var cam : Camera3D = %Camera3D
@onready var cam_anchor: Node3D = %CamAnchor
@onready var buildings: Node3D = %Buildings


func _ready():
	Locator.factory_assets3d = self


## this script is the proxy between 3d and 2d
func spawn_3d_object(pos2d: Vector2, rot2d: float, obj_type: int) -> Node3D:

	var asset_to_use

	match obj_type:
		0:
			asset_to_use = building_asset1
		1:
			asset_to_use = building_asset2
		2:
			asset_to_use = building_asset3
		3:
			asset_to_use = building_asset4
		4:
			asset_to_use = building_asset5


	var building = asset_to_use.instantiate()
	building.position = Vector3(pos2d.x, 0, pos2d.y) / 100.0
	building.rotation = Vector3(0, -rot2d, 0)
	buildings.call_deferred("add_child", building)
	
	return building


func set_cam_position(pos: Vector3):
	cam_anchor.position = pos
