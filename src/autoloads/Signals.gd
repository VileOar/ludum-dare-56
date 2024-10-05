## autoload for global signals
extends Node


## emited by a creature to request spawning a new infected creature
@warning_ignore("unused_signal")
signal spawn_infected_request(position)

## sent by a creature when they cross the goal
@warning_ignore("unused_signal")
signal creature_clear(is_infected)

@warning_ignore("unused_signal")
signal cam_has_moved(mov_vec)
