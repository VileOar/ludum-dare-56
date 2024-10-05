extends Node


## a global scope RNG
var rng := RandomNumberGenerator.new()

## Game Variables
# In City
var total_population : int = 0
var infected_population : int = 0
var healthy_population : int = 0
var death_toll : int = 0

# In Soup
var total_population_soup : int = 0
var infected_soup : int = 0
var healthy_soup : int = 0


func _ready():
	randomize() # randomise the global-scope random functions
	rng.randomize() # randomise the RNG instance
