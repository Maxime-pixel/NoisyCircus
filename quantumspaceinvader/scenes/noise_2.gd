extends Area2D

const SPEED = 50
var sign = 1
var player
var norm

func _ready() -> void:
	var difference = position - player.global_position
	norm = difference.normalized()

func _physics_process(delta: float) -> void:
	position.x -= norm.x * delta * SPEED
	position.y -= norm.y * delta * SPEED
	if position.x > 2000 or position.x < -2000 or position.y > 1100 or position.y < -1100 :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	body._take_damage()
