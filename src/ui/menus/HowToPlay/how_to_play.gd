extends Control


func _on_back_menu_button_pressed():
	AudioManager.play_audio("ButtonPress")
	self.visible = false


func _on_back_menu_button_mouse_entered():
	AudioManager.play_audio("ButtonHover")
