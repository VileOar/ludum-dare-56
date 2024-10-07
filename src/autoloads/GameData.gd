extends Node


const ROUND_TIME = 120.0
const INFECTED_PENALTY = 3

var score: int = 0

var score_thresholds = {
	0: "D",
	25: "C",
	60: "B",
	100: "A",
	150: "S",
}

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

var _timer : Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# init all stats at 0
	for stat in GameStats.values():
		_game_stats[stat] = 0
	
	_timer = Timer.new()
	_timer.wait_time = ROUND_TIME
	_timer.one_shot = true
	_timer.autostart = false
	add_child(_timer)
	
	_timer.timeout.connect(_on_timer_end)


func start_timer(time = ROUND_TIME):
	_timer.start(time)


func get_remaining_time() -> float:
	return _timer.time_left


func _on_timer_end():
	Signals.round_end.emit()


func get_rank() -> String:
	var temp_string

	for threshold in score_thresholds:
		if score >= threshold:
			
			temp_string = score_thresholds[threshold]

	return temp_string


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
	if infected:
		score = max(score - INFECTED_PENALTY, 0)
	else:
		score += 1


## should be called whenever a creature reaches the death state
func creature_died(_infected: bool):
	add_game_stat(GameStats.CITY_DEATH, 1)


## should be called whenever a creature exits the scene tree, even if not killed by damage
func creature_removed(infected: bool):
	add_game_stat(GameStats.CITY_INFECTED if infected else GameStats.CITY_HEALTHY, -1)


## should be called whenever a creature enters the scene tree
func creature_spawn(infected: bool):
	add_game_stat(GameStats.CITY_INFECTED if infected else GameStats.CITY_HEALTHY, 1)
