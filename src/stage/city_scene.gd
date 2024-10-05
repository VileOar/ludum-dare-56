extends Node3D

@onready var cam : Camera3D = $Camera3D


func _ready():
	Signals.cam_has_moved.connect(set_cam_pos)


func set_cam_pos(new_pos : Vector2):
	var temp_vec3 = Vector3(new_pos.x, 0, new_pos.y)
	cam.position = cam.position + temp_vec3.normalized() * 0.04
