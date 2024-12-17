class_name OptionsMenu
extends Control


@onready var back_button : Button = %BackMenuButton
@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sound_slider: HSlider = %SoundSlider


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


func _on_back_pressed() -> void:
	_play_click_sfx()
	self.visible = false
