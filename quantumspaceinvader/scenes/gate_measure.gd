extends Area2D
var SPEED = 20
var sign = 1

func _physics_process(delta: float) -> void:
	position += Vector2(0, SPEED) * delta * sign
