extends Area2D

var preload_qubits = preload("res://scenes/player.tscn")
@onready var new_qubit: Area2D = $"../NewQubit"

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
	var new_player = preload_qubits.instantiate()
	print(cnot_lenght())
	new_player.global_position.x = body.global_position.x + cnot_lenght()
	new_player.global_position.y = body.global_position.y
	
	
	if left_cnot and not body.left_entangled:
		body.left_entangled = true
		new_player.right_entangled = true
		
	elif not left_cnot and not body.right_entangled:
		body.right_entangled = true
		new_player.left_entangled = true
		
	
	get_tree().current_scene.call_deferred("add_child", new_player)
	cnot.queue_free()
