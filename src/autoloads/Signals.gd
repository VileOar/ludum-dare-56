## autoload for global signals
extends Node


## emited when the top-level node is ready
@warning_ignore("unused_signal")
signal toplevel_ready

## emited by a creature to request spawning a new infected creature
@warning_ignore("unused_signal")
signal spawn_infected_request(position)

## emited to spawn a 3d object
@warning_ignore("unused_signal")
signal spawn_3d_asset(pos2d)

## sent when a game stat is altered
@warning_ignore("unused_signal")
signal stat_update(stat, new_value)

@warning_ignore("unused_signal")
signal cam_has_moved(mov_vec)
