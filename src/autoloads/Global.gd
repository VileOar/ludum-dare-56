extends Node

## how many infected to spawn when a healthy is infected (OTHER thatn itself)
const INFECTED_SPAWN_ADDITIONAL = 1


## a global scope RNG
var rng := RandomNumberGenerator.new()

func _ready():
	randomize() # randomise the global-scope random functions
	rng.randomize() # randomise the RNG instance
