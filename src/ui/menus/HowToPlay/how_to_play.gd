extends Control

signal hide_toggle(vis)

@onready var how_to_play = $"."


func _on_back_menu_button_pressed():
	toggle_visibility(false)


func toggle_visibility(vis):
	how_to_play.visible = vis
	hide_toggle.emit(how_to_play.visible)
