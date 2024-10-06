extends StaticBody2D
class_name StageHazard


func _ready() -> void:
	await Signals.toplevel_ready
	Signals.spawn_3d_asset.emit(position)
