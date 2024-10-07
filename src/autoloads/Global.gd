extends Node

## how many infected to spawn when a healthy is infected (OTHER thatn itself)
const INFECTED_SPAWN_ADDITIONAL = 1

## max number of creatures spawned when building is detroyed
const MAX_CREATURES_PER_BUILDING = 5
## min number of creatures spawned when building is detroyed
const MIN_CREATURES_PER_BUILDING = 2
## chance to spawn infected when building is destroyed
const BUILDING_INFECTED_CHANCE = 0.3

## a global scope RNG
var rng := RandomNumberGenerator.new()


var viewport_size = Vector2.ZERO

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

	viewport_size = get_viewport().get_visible_rect().size
