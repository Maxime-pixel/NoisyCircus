extends Area2D
var SPEED = 80
var sign = 1
var player_list


func _physics_process(delta: float) -> void:
	position += Vector2(0, SPEED) * delta * sign

func _on_body_entered(body: Node2D) -> void:
	if len(player_list.player_list) > 1:
		body._take_damage()
