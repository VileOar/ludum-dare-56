extends StackState
class_name ClearState

# TODO: this state is full of placeholder code

@onready var _controller: BaseController = _fsm as BaseController

const ANIM_DURATION = 1.0


func activate():
	_controller.body.enable_collision(false)
	get_tree().create_timer(ANIM_DURATION).timeout.connect(_destroy)
	AudioManager.play_audio("Yippee")
	_controller.sprite.play("clear")


func _physics_process(delta: float) -> void:
	(_controller.body.get_node("Polygon2D") as Polygon2D).rotate(2*PI*delta)
	_controller.body.move_and_collide(Vector2.RIGHT * 32 * delta)


func allow_next_state(_state: String):
	return false


func _destroy():
	GameData.creature_clear(_controller.body.get_infected())
	_controller.body.destroy()
