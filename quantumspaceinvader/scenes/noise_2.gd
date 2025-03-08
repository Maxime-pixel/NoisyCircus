extends Area2D

const SPEED = 100
var sign = 1
var player
var norm

func _ready() -> void:
	var difference = position - player.global_position
	norm = difference.normalized()

func _physics_process(delta: float) -> void:
	position.x -= norm.x * delta * SPEED
	position.y -= norm.y * delta * SPEED

func _on_body_entered(body: Node2D) -> void:
	print("touched")
	
	#body._take_damage()
