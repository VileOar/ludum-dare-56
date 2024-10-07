extends MarginContainer


##Godzilla
const MOVEMENT_START :float = 75.0
const MOVEMENT_END :float = 1630.0

@onready var stat_labels:= {
	GameData.GameStats.CITY_INFECTED: %CityInfected,
	GameData.GameStats.CITY_HEALTHY: %CityGood,
	GameData.GameStats.CITY_DEATH: %CityDeath,
	GameData.GameStats.SOUP_INFECTED: %SoupInfected,
	GameData.GameStats.SOUP_HEALTHY: %SoupGood,
}


func _ready() -> void:
	Signals.stat_update.connect(_on_stat_update)


func _process(_delta: float) -> void:
	var weight = (GameData.ROUND_TIME - GameData.get_remaining_time()) / GameData.ROUND_TIME
	%GodzillaPosition.position.x = lerp(MOVEMENT_START, MOVEMENT_END, weight)


## callback for when a stat is updated[br]
## this must connect to the appropriate global signal
func _on_stat_update(stat, new_value):
	stat_labels[stat].text = str(new_value)
	
	var city_infected = GameData.get_game_stat(GameData.GameStats.CITY_INFECTED)
	var city_healthy = GameData.get_game_stat(GameData.GameStats.CITY_HEALTHY)
	var soup_infected = GameData.get_game_stat(GameData.GameStats.SOUP_INFECTED)
	var soup_healthy = GameData.get_game_stat(GameData.GameStats.SOUP_HEALTHY)
	%CityTotal.text = str(city_healthy + city_infected)
	%SoupTotal.text = str(soup_healthy + soup_infected)
