extends Node3D
class_name CityScene

@export var building_asset: PackedScene

@onready var cam : Camera3D = %Camera3D
@onready var cam_anchor: Node3D = %CamAnchor
@onready var buildings: Node3D = %Buildings


func _ready():
	Signals.spawn_3d_asset.connect(_spawn_3d_object)


## this script is the proxy between 3d and 2d
func _spawn_3d_object(pos2d: Vector2, caller):
	var building = building_asset.instantiate()
	building.position = Vector3(pos2d.x, 0, pos2d.y) / 100.0
	buildings.add_child(building)
	
	# this is very bad code, don't care
	(caller as StageHazard).set_asset(building)


func set_cam_position(pos: Vector3):
	cam_anchor.position = pos
