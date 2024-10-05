extends Node


## a global scope RNG
var rng := RandomNumberGenerator.new()

func _ready():
	randomize() # randomise the global-scope random functions
	rng.randomize() # randomise the RNG instance
