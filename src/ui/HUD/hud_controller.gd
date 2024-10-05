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
@onready var time_label: Label = %SoupTime
@onready var timer_logic = %Time

# City
@onready var total_population: Label = %CityTotal
@onready var infected: Label = %CityInfected
@onready var healthy: Label = %CityGood
@onready var death_toll: Label = %CityDeath

# Soup
@onready var total_soup: Label = %SoupTotal
@onready var infected_soup: Label = %SoupInfected
@onready var healthy_soup: Label = %SoupGood


func _ready() -> void:
	# Connects signal from time script
	timer_logic.time_tick.connect(_progress_time)
	# TODO signal that updates game data
	#game_logic.game_data_update(_update_data)
	_update_data()


## Updates time in UI
func _progress_time(total_seconds : int) -> void:
	time_label.text = TIME_STR + str(total_seconds) + " s"


## Updates game data in UI
# might not be the most efficient way to update the ui
func _update_data() -> void:
	total_population.text = TOTAL_POPULATION_STR + str(Global.total_population)
	healthy.text = HEALTHY_STR + str(Global.healthy_population)
	infected.text = INFECTED_STR + str(Global.infected_population)
	death_toll.text = DEATH_TOOL_STR + str(Global.death_toll)
	
	total_soup.text = TOTAL_POPULATION_STR + str(Global.total_population_soup)
	healthy_soup.text = HEALTHY_STR + str(Global.healthy_soup)
	infected_soup.text = INFECTED_STR + str(Global.infected_soup)
