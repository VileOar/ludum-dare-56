extends Control


@onready var _rank_label: Label = %RankVariable



func _ready() -> void:
	AudioManager.play_audio("GoodSoup")

	if _rank_label:
		_rank_label.text = GameData.get_rank()
