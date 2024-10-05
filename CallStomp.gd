extends Node2D

@export var myStompScene: PackedScene
@onready var _detector: Area2D = %Detector

var _radius: int = 0
var _tween

const STARTUP_DURATION: float = 0.2 ## (sec) time it takes for startup animation
const MAX_RADIUS: int = 128
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1"):
		show()
		global_position = get_global_mouse_position()
		_tween = get_tree().create_tween()
		_radius = 0
		_tween.tween_property(self, "_radius", MAX_RADIUS, STARTUP_DURATION)
		
	if event.is_action_released("mouse1"):
		var Stomp = myStompScene.instantiate()
		Stomp.position = get_local_mouse_position()
		add_child(Stomp)
