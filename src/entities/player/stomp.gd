extends Area2D
class_name Stomp

const LIFESPAN = 0.3


func _ready() -> void:
	var timer = get_tree().create_timer(LIFESPAN)
	timer.timeout.connect(_on_lifespan_end)


func _on_body_entered(body: Node2D) -> void:
	if body is Creature:
		body.die()
	elif body is StaticBody2D:
		body.queue_free()


func _on_lifespan_end():
	queue_free()
