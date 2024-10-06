class_name MainMenu
extends Control

@export var game_scene: PackedScene

#Buttons
@onready var start_game_button : Button = %PlayButton
@onready var how_to_play_button : Button = %HowToPlayButton
@onready var options_menu_button : Button = %OptionsButton
@onready var credits_button : Button = %CreditsButton
@onready var exit_button : Button = %ExitButton

#@onready var options_menu_node : OptionsMenu = $OptionsMenu
#@onready var credits = $Credits
#@onready var how_to_play = $HowToPlay

func _ready():
	#options_menu_node.visible = false
# Connects buttons to functions
	#start_game_button.grab_focus()
	start_game_button.button_down.connect(_on_start_pressed)
	options_menu_button.button_down.connect(_on_options_pressed)
	exit_button.button_down.connect(_on_exit_pressed)
	
	#button hover audio
	start_game_button.mouse_entered.connect(_play_hover_sfx)
	how_to_play_button.mouse_entered.connect(_play_hover_sfx)
	options_menu_button.mouse_entered.connect(_play_hover_sfx)
	credits_button.mouse_entered.connect(_play_hover_sfx)
	exit_button.mouse_entered.connect(_play_hover_sfx)
	

func _play_click_sfx() -> void:
	AudioManager.play_audio("ButtonPress")
	pass

func _play_hover_sfx() -> void:
	AudioManager.play_audio("ButtonHover")
	pass

# Starts game
func _on_start_pressed() -> void:
	_play_click_sfx()
	#SoundManager.instance.play_correct_sfx()
	get_tree().change_scene_to_packed(game_scene)

func _on_how_to_play_button_pressed():
	_play_click_sfx()
	#how_to_play.visible = true

func _on_options_pressed() -> void:
	_play_click_sfx()
	#options_menu_node.visible = true
	
func _on_credits_button_pressed():
	_play_click_sfx()
	#credits.visible = true
	
	
# Exists game
func _on_exit_pressed() -> void:
	_play_click_sfx()
	get_tree().quit()
