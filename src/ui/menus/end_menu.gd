extends Control

@export var game_scene: PackedScene

@onready var _rank_label: Label = %Rank

func _ready() -> void:
	var _rank = GameData.get_rank()
	_rank_label.text = _rank
	
	var soup_infected = GameData.get_game_stat(GameData.GameStats.SOUP_INFECTED)
	var soup_healthy = GameData.get_game_stat(GameData.GameStats.SOUP_HEALTHY)
	%SoupTotal.text = str(soup_healthy + soup_infected)
	%SoupInfected.text = str(soup_infected)
	%SoupGood.text = str(soup_healthy)
	
	if _rank == "D" || _rank == "C" :
		AudioManager.play_audio("Vomit")
		$BadEnding.visible = true
		$GoodEnding.visible = false
	else :
		AudioManager.play_audio("GoodSoup")
		$BadEnding.visible = false
		$GoodEnding.visible = true


func _on_main_menu_btn_pressed() -> void:
	AudioManager.stop_audio("Vomit")
	AudioManager.stop_audio("GoodSoup")
	get_tree().change_scene_to_packed(game_scene)
