extends Node2D

var score = 0 
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	label.text = "Time before the next wave: " + str(timer.time_left)
