extends Node2D

var MEASURECHANCES = 200
var rng = RandomNumberGenerator.new()
var particle = preload("res://scenes/noise_2.tscn")
var measure = preload("res://scenes/gate_measure.tscn")
@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer
var is_active = true
var counter = 0
var speed_incr = 200
var elapsed_time = 0.0  # Tracks total time

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
	counter += 1
	elapsed_time += timer.wait_time  # Track elapsed time

	if elapsed_time >= 10:  # Print every 10 seconds
		print("10 seconds have passed")
		elapsed_time = 0  # Reset time counter
		if speed_incr + new_node.SPEED < 300:
			new_node.SPEED += speed_incr

	if timer.wait_time > 0.2:
		timer.wait_time -= 0.05
		timer.start()  # Restart timer with new wait_time
	if rng.randf() > 0.5:
		new_node.position.y *= -1
		new_node.sign = -1
	add_child(new_node)
