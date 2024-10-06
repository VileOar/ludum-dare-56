extends Node3D

@export var building_asset: PackedScene

@onready var cam : Camera3D = %Camera3D
@onready var cam_anchor: Node3D = %CamAnchor
@onready var buildings: Node3D = %Buildings

@onready var stage2d: Node2D = %Stage

var screen_size
var screen_size_pan_margins
var margin_rate = 10

var pan_speed = 10

var mouse_pos = Vector2.ZERO
var cam_move_direction = Vector2.ZERO
var mouse_border = {"top": false, "bottom": false, "left": false, "right": false}

#@onready var cam_anchor : Node2D = %CameraAnchor


func _ready():
	#Signals.cam_has_moved.connect(set_cam_pos)
	Signals.spawn_3d_asset.connect(_spawn_3d_object)
	
	Signals.toplevel_ready.emit()
	
	screen_size = get_viewport().get_visible_rect().size
	screen_size_pan_margins = screen_size.x / margin_rate


func _physics_process(_delta: float) -> void:
	mouse_pos = get_viewport().get_mouse_position()
	cam_move_direction = Vector3.ZERO

	mouse_border["top"] = mouse_pos.y < screen_size_pan_margins
	mouse_border["bottom"] = mouse_pos.y > screen_size.y - screen_size_pan_margins
	mouse_border["left"] = mouse_pos.x < screen_size_pan_margins
	mouse_border["right"] = mouse_pos.x > screen_size.x - screen_size_pan_margins

	if mouse_border["right"]:
		cam_move_direction.x += 1
	elif mouse_border["left"]:
		cam_move_direction.x -= 1

	if mouse_border["bottom"]:
		cam_move_direction.z += 1
	elif mouse_border["top"]:
		cam_move_direction.z -= 1

	#Signals.cam_has_moved.emit(cam_move_direction)
	cam_anchor.position = cam_anchor.position + cam_move_direction.normalized() * 0.1
	stage2d.position = Vector2(-cam_anchor.position.x, -cam_anchor.position.z) * 100


#func set_cam_pos(new_pos : Vector2):
	#var temp_vec3 = Vector3(new_pos.x, 0, new_pos.y)
	#cam.position = cam.position + temp_vec3.normalized() * 0.04


## this script is the proxy between 3d and 2d
func _spawn_3d_object(pos2d: Vector2):
	var building = building_asset.instantiate()
	building.position = Vector3(pos2d.x, 0, pos2d.y) / 100.0
	buildings.add_child(building)
