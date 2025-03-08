extends Node2D

var MEASURECHANCES = 200
var rng = RandomNumberGenerator.new()
var particle = preload("res://scenes/noise_2.tscn")
var measure = preload("res://scenes/gate_measure.tscn")
@onready var player: CharacterBody2D = %Player
var is_active = true

func _on_timer_timeout() -> void:
	if is_active == false :
		return
	var rand_num = rng.randi_range(0, MEASURECHANCES)
	var new_node
	if rand_num == 0:
		new_node = measure.instantiate()
	else:
		new_node = particle.instantiate()
		new_node.player = player
	new_node.position = Vector2(rng.randf_range(-1920, 1920), -1080)
	if rng.randf() > 0.5:
		new_node.position.y *= -1
		new_node.sign = -1
	add_child(new_node)
