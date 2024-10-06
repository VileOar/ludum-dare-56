extends StaticBody2D
class_name StageHazard

var _asset: Node3D


func _ready() -> void:
	await Signals.toplevel_ready
	Signals.spawn_3d_asset.emit(position, self)


func set_asset(asset: Node3D):
	_asset = asset


func stomped():
	# TODO: do something else
	_asset.queue_free()
	queue_free()
