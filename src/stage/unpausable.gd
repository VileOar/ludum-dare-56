# THIS NODE EXISTS TO HAVE PROCESS MODE SET TO ALWAYS
extends Node

const FADE_DURATION = 0.05
const END_LAG = 1.0

@onready var _fade: ColorRect = %Fade


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.round_end.connect(_on_round_end)


func _on_round_end():
	get_tree().paused = true
	AudioManager.stop_audio("Music1")
	await get_tree().create_timer(END_LAG).timeout
	var tween = create_tween()
	_fade.modulate = Color(Color.BLACK, 0)
	tween.tween_property(_fade, "modulate", Color(Color.WHITE, 1), 0.5)
	await tween.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/ui/menus/end_menu.tscn")
