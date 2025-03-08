extends Node2D
@onready var new_qubit: Area2D = $NewQubit
@onready var control: Area2D = $Control
var SPEED = 40
var MIN_DIST = 150
var MAX_DIST = 500
func _draw():
	draw_line(control.position, new_qubit.position , Color(0, 0, 1), 5)

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var left_distance = rng.randf_range(MAX_DIST, MIN_DIST)
	var right_distance =  rng.randf_range(-MAX_DIST, -MIN_DIST)
	
	control.distance = abs(left_distance - right_distance)
	var sign = 1
	if rng.randi_range(1, 2) == 2:
		sign = -1
		control.left_cnot = true
	else:
		control.left_cnot = false
	
	control.position.x += right_distance * sign
	new_qubit.position.x -= right_distance * sign
	
	
func _physics_process(delta: float) -> void:
	
	position.y += SPEED * delta
