extends Area2D
@onready var new_qubit: Area2D = $"../NewQubit"
@onready var player_list: Node2D = get_tree().current_scene.get_node("PlayerList")


@onready var cnot: Node2D = $".."
var left_cnot
var distance

func cnot_lenght():
	if not left_cnot:
		return distance
	else:
		return -distance

func _on_body_entered(body: Node2D) -> void:
	
	if player_list.player_list[0] !=  body and player_list.player_list[-1] != body:
		cnot.queue_free()
		return
		
	print(left_cnot)
	player_list.player_add(body, distance, left_cnot)
	
	cnot.queue_free()
