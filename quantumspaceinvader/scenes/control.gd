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
	
	if left_cnot and body.left_entangled or (not left_cnot) and body.right_entangled:
		cnot.queue_free()
		return
	
	player_list.player_add(body, distance, left_cnot)
	
	cnot.queue_free()
