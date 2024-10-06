extends MarginContainer

# UI NAMES
const TIME_STR = "Time: "
const TOTAL_POPULATION_STR = "Total: "
const INFECTED_STR = "Infected: "
const HEALTHY_STR = "Healthy: "
const DEATH_TOOL_STR = "Death: "

#const TOTAL_POPULATION_SOUP_STR = "Total: "
#const INFECTED_SOUP_STR = "Infected: "
#const HEALTHY_SOUP_STR = "Healthy: "

# UI
@onready var timer_logic = %Time

## City
#@onready var total_city: Label = %CityTotal
#@onready var infected_city: Label = %CityInfected
#@onready var healthy_city: Label = %CityGood
#@onready var death_city: Label = %CityDeath
#
## Soup
#@onready var total_soup: Label = %SoupTotal
#@onready var infected_soup: Label = %SoupInfected
#@onready var healthy_soup: Label = %SoupGood
#@onready var time_label: Label = %SoupTime

@onready var stat_labels:= {
	GameData.GameStats.CITY_INFECTED: %CityInfected,
	GameData.GameStats.CITY_HEALTHY: %CityGood,
	GameData.GameStats.CITY_DEATH: %CityDeath,
	GameData.GameStats.SOUP_INFECTED: %SoupInfected,
	GameData.GameStats.SOUP_HEALTHY: %SoupGood,
}


func _ready() -> void:
	# Connects signal from time script
	timer_logic.time_tick.connect(_progress_time)
	# TODO signal that updates game data
	#game_logic.game_data_update(_update_data)
	#_update_data()
	
	Signals.stat_update.connect(_on_stat_update)


## Updates time in UI
func _progress_time(total_seconds : int) -> void:
	pass#time_label.text = TIME_STR + str(total_seconds) + " s"


## Updates game data in UI
# might not be the most efficient way to update the ui
#func _update_data() -> void:
	#total_population.text = TOTAL_POPULATION_STR + str(Global.total_population)
	#healthy.text = HEALTHY_STR + str(Global.healthy_population)
	#infected.text = INFECTED_STR + str(Global.infected_population)
	#death_toll.text = DEATH_TOOL_STR + str(Global.death_toll)
	#
	#total_soup.text = TOTAL_POPULATION_STR + str(Global.total_population_soup)
	#healthy_soup.text = HEALTHY_STR + str(Global.healthy_soup)
	#infected_soup.text = INFECTED_STR + str(Global.infected_soup)


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
