extends Area2D
class_name Stomp

const LIFESPAN = 0.3


func _ready() -> void:
	var timer = get_tree().create_timer(LIFESPAN)
	timer.timeout.connect(_on_lifespan_end)


func _on_body_entered(body: Node2D) -> void:
	body.die()


func _on_lifespan_end():
	queue_free()
