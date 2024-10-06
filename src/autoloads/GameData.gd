extends Node


## Stat IDs
enum GameStats {
	CITY_INFECTED,
	CITY_HEALTHY,
	CITY_DEATH,
	SOUP_INFECTED,
	SOUP_HEALTHY,
}
## dict holding data
var _game_stats = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# init all stats at 0
	for stat in GameStats.values():
		_game_stats[stat] = 0


func get_game_stat(stat: int) -> int:
	if _game_stats.has(stat):
		return _game_stats[stat]
	push_error("Invalid game stat '%s'" % stat)
	return -1


func set_game_stat(stat: int, value: int):
	if _game_stats.has(stat):
		_game_stats[stat] = value
		Signals.stat_update.emit(stat, value)
	else:
		push_error("Invalid game stat '%s'" % stat)


func add_game_stat(stat: int, delta: int):
	set_game_stat(stat, get_game_stat(stat) + delta)


## should be called whenever a creature reaches the clear state
func creature_clear(infected: bool):
	add_game_stat(GameStats.SOUP_INFECTED if infected else GameStats.SOUP_HEALTHY, 1)


## should be called whenever a creature reaches the death state
func creature_died(_infected: bool):
	add_game_stat(GameStats.CITY_DEATH, 1)


## should be called whenever a creature exits the scene tree, even if not killed by damage
func creature_removed(infected: bool):
	add_game_stat(GameStats.CITY_INFECTED if infected else GameStats.CITY_HEALTHY, -1)


## should be called whenever a creature enters the scene tree
func creature_spawn(infected: bool):
	add_game_stat(GameStats.CITY_INFECTED if infected else GameStats.CITY_HEALTHY, 1)
