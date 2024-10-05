extends Area2D
class_name Stomp

const LIFESPAN = 0.3


func _ready() -> void:
	var timer = get_tree().create_timer(LIFESPAN)
	timer.timeout.connect(_on_lifespan_end)


func _process(_delta: float) -> void:
	queue_redraw()


func _on_body_entered(body: Node2D) -> void:
	body.die()


func _on_lifespan_end():
	queue_free()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 128, Color.RED)
