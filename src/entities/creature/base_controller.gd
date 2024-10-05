## base controller for all types of creatures
extends StackStateMachine
class_name BaseController

@onready var body: CharacterBody2D = get_parent() as CharacterBody2D

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var detector: Area2D = %Detector


func _ready() -> void:
	super._ready()
	push_state("IdleState")
