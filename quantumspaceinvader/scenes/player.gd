extends CharacterBody2D


const SPEED = 300.0
var max_health = 10
var health = max_health
var look_up = true
@onready var spawner: Node2D = $"../Spawner"

var projectile = preload("res://scenes/projectiile.tscn")

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if not look_up and Input.is_action_pressed("move_up"):
		rotate(3.14)
		look_up = true
		
	elif look_up and Input.is_action_pressed("move_down"):
		rotate(-3.14)
		look_up = false

	move_and_slide()


func _on_timer_timeout() -> void:
	var new_projectile = projectile.instantiate()
	var sign = -1
	if not look_up:
		sign = 1
	new_projectile.position = position + Vector2(0,  sign * 100)
	new_projectile.up = -sign
	get_tree().root.add_child(new_projectile)


func _take_damage() -> void:
	
	self.queue_free()
	
	
	
