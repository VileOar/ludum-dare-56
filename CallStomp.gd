extends Node2D

@export var myStompScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1"):
		print("Stomp")
	if event.is_action_released("mouse1"):
		var Stomp = myStompScene.instantiate()
		Stomp.position = get_local_mouse_position()
		add_child(Stomp)
