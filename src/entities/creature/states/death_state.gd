extends StackState
class_name DeathState

# TODO: this state should later receive more animation and such

@onready var _controller: BaseController = _fsm as BaseController

const ANIM_DURATION = 0.3


func activate():
	AudioManager.play_audio("Dying")
	_controller.body.enable_collision(false)
	var tween = create_tween()
	await tween.tween_property(_controller.body, "modulate", Color(Color.WHITE, 0), ANIM_DURATION).finished
	GameData.creature_died(_controller.body.get_infected())
	_controller.body.destroy()
	
	_controller.sprite.play("death")


func allow_next_state(_state: String):
	return false
