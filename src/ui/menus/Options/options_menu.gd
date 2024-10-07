class_name OptionsMenu
extends Control

#@onready var start_game_button : Button = $Background/MarginContainer/HorizontalContainer/MarginContainer/VButtonsContainer/PlayButton
@onready var back_button : Button = $MarginContainer/HorizontalContainer/MarginContainer/VButtonsContainer/BackContainer/BackButton

@onready var master_slider: HSlider = $MarginContainer/HorizontalContainer/MarginContainer/VButtonsContainer/MasterVolumeContainer/SliderContainer/MasterSlider
@onready var music_slider: HSlider = $MarginContainer/HorizontalContainer/MarginContainer/VButtonsContainer/MusicVolumeContainer3/SliderContainer/MusicSlider
@onready var sound_slider: HSlider = $MarginContainer/HorizontalContainer/MarginContainer/VButtonsContainer/SoundVolume/SliderContainer/SoundSlider



func _ready():
# Connects buttons to functions
	back_button.button_down.connect(_on_back_pressed)

# Connects buttons to Hover
	back_button.mouse_entered.connect(_play_hover_sfx)
	master_slider.mouse_entered.connect(_play_hover_sfx)
	music_slider.mouse_entered.connect(_play_hover_sfx)
	sound_slider.mouse_entered.connect(_play_hover_sfx)

func _play_click_sfx() -> void:
	AudioManager.play_audio("ButtonPress")


func _play_hover_sfx() -> void:
	AudioManager.play_audio("ButtonHover")


# back to main menu
func _on_back_pressed() -> void:
	_play_click_sfx()
	self.visible = false
