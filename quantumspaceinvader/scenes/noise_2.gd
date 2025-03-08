extends Area2D

const SPEED = 300.0



func _physics_process(delta: float) -> void:
	
	position = position + Vector2(0,20)*delta
	
	

func _on_body_entered(body: Node2D) -> void:
	print("touched")
	
	
	
	body._take_damage()
	
	
	
	
