extends Node2D
@onready var new_qubit: Area2D = $NewQubit
@onready var control: Area2D = $Control
var SPEED = 100
var MIN_DIST = 300
var MAX_DIST = 800
var rng = RandomNumberGenerator.new()

 changes
func _draw():
	draw_line(control.position, new_qubit.position , Color.BLACK, 5)

func _ready() -> void:
	
	var left_distance = rng.randf_range(MAX_DIST, MIN_DIST)
	var right_distance =  rng.randf_range(-MAX_DIST, -MIN_DIST)
	
	control.distance = abs((right_distance - left_distance) / 2)
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
