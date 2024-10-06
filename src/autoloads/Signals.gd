## autoload for global signals
extends Node


## emited by a creature to request spawning a new infected creature
@warning_ignore("unused_signal")
signal spawn_infected_request(position)

## sent when a game stat is altered
@warning_ignore("unused_signal")
signal stat_update(stat, new_value)

@warning_ignore("unused_signal")
signal cam_has_moved(mov_vec)
