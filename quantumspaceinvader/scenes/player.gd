extends CharacterBody2D


const SPEED = 1000.0
var max_health = 10
var health = max_health
var look_up = true
@onready var spawner: Node2D = $"../../Spawner"
@onready var player_list: Node2D = $".."
@onready var game_over_screen: Node2D = $"../../GameOver"


var left_entangled = false
var right_entangled = false

var player_index = 1

var projectile = preload("res://scenes/projectiile.tscn")

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("switch") or Input.is_action_just_pressed("switch"):
		rotate(PI)
		look_up = not look_up

	move_and_slide()
	position.x = wrapf(position.x, -2250, 2250)


func _on_timer_timeout() -> void:
	var new_projectile = projectile.instantiate()
	var sign = -1
	if not look_up:
		sign = 1
	new_projectile.position = position + Vector2(0,  sign * 115)
	new_projectile.up = -sign
	get_tree().root.add_child(new_projectile)

func _take_damage() -> void:
	print('taking damage')
	if len(player_list.get_children()) == 1:
		print('game over...')
		game_over_screen.visible = true
	self.queue_free()
