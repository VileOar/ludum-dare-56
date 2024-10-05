## autoload for global signals
extends Node


## emited by a creature to request spawning a new infected creature
@warning_ignore("unused_signal")
signal spawn_infected_request(position)
