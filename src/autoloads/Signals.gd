## autoload for global signals
extends Node


## emited when the top-level node is ready
@warning_ignore("unused_signal")
signal toplevel_ready

## sent when a game stat is altered
@warning_ignore("unused_signal")
signal stat_update(stat, new_value)

@warning_ignore("unused_signal")
signal screen_shake(intesity)

@warning_ignore("unused_signal")
signal round_end
