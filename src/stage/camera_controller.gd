extends Node2D
class_name CustomCamera

@export var scene3d: CityScene
@export var pan_speed = 10
var cam_move_direction = Vector2.ZERO
var screen_size
## total area in pixels of map, that cam can move in
var _total_area: Rect2
var _custom_mod := 56

## must account for hud height
const HUD_HEIGHT = 256

@onready var cam_anchor: Node2D = %CameraAnchor
@onready var cam: Camera2D = %MainCam
@onready var how_to_play: Control = %HowToPlay

# Screen shake vars
var trauma := 0.0
@export var trauma_reduction_rate := 1.6
@export var max_x := 60
@export var max_y := 60
@export var _tilemap: TileMapLayer

@export var noise : FastNoiseLite
@export var noise_speed := 700
var time := 0.0


func _ready():
	screen_size = get_viewport().get_visible_rect().size

	Signals.screen_shake.connect(_add_noise)
	Signals.pause.connect(_show_how_to)
	
	_total_area = _tilemap.get_used_rect() as Rect2
	var cellsize = (_tilemap.tile_set.tile_size as Vector2) * _tilemap.scale
	_total_area.position *= cellsize
	_total_area.size *= cellsize # at this point, total area is equal to the full area in pixels of the map
	
	# half screen size margin on top and left
	_total_area.position += screen_size / 2
	# half screen size margin on bottom and right (do NOT divide by 2,
	# because end was shifted by half screen size after previous line of code, so must compensate)
	_total_area.end -= screen_size


func _process(delta):
	time += delta
	trauma = max(trauma - delta * trauma_reduction_rate * trauma_reduction_rate, 0.0)
	
	cam.position.x = max_x * trauma * trauma * _get_noise_from_seed(0)
	cam.position.y = max_y * trauma * trauma * _get_noise_from_seed(1)


func _physics_process(_delta: float) -> void:

	cam_move_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

	var mov_dir = cam_move_direction.normalized() * pan_speed
	cam_anchor.position.x = clamp(cam_anchor.position.x + mov_dir.x, _total_area.position.x, _total_area.end.x)
	cam_anchor.position.y = clamp(cam_anchor.position.y + mov_dir.y, _total_area.position.y, _total_area.end.y + HUD_HEIGHT - _custom_mod)
	scene3d.set_cam_position(Vector3(cam_anchor.position.x, 0, cam_anchor.position.y)/100)


func _add_noise(trauma_amount : float):
	trauma = clamp(trauma + trauma_amount, 0.0, 1.0)


func _get_noise_from_seed(_seed : int) -> float:
	noise.seed = _seed
	return noise.get_noise_1d(time * noise_speed)


func get_map_rect(account_hud: bool = false) -> Rect2:
	var viewport_rect = get_viewport_rect()
	viewport_rect.position = cam_anchor.global_position - viewport_rect.size/2
	if account_hud:
		viewport_rect.end.y -= HUD_HEIGHT
	return viewport_rect

func _show_how_to():
	how_to_play.visible = true
