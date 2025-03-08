extends Node2D

var rng = RandomNumberGenerator.new()
var particle = preload("res://scenes/noise_2.tscn")
@onready var player: CharacterBody2D = %Player
var is_active = true

func _on_timer_timeout() -> void:
	if is_active == false :
		return
	var new_particle = particle.instantiate()
	if rng.randf() > 0.5:
		new_particle.position = Vector2(rng.randf_range(-1920, 1920), -1080)
	else:
		new_particle.position = Vector2(rng.randf_range(-1920, 1920), 1080)
		new_particle.sign = -1
	new_particle.player = player
	add_child(new_particle)
