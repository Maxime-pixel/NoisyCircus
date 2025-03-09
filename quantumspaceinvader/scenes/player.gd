extends CharacterBody2D


const SPEED = 1000.0
var max_health = 10
var health = max_health
var look_up = true
var playerID
@onready var spawner: Node2D = $"../../Spawner"
@onready var player_list: Node2D = $".."
@onready var game_over_screen: Node2D = $"../../GameOver"
@onready var alice_appears: AudioStreamPlayer2D = $AliceAppears
@onready var timer: Timer = $Timer
@onready var alice_death: AudioStreamPlayer2D = $aliceDeath
@onready var toffoli: Area2D = $"../../toffoli"


var left_entangled = false
var right_entangled = false

var player_index = 1

var projectile = preload("res://scenes/projectiile.tscn")

func _ready() -> void:
	$DownwardCollisionShape.disabled = true
	alice_appears.play()

func _physics_process(delta: float) -> void:
	
	if len(player_list.player_list) == 0:
		game_over_screen.visible = true
		self.disable_mode

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Input.is_action_just_pressed("switch") or Input.is_action_just_pressed("switch"):
		look_up = not look_up
		$UpwardCollisionShape.disabled = not $UpwardCollisionShape.disabled
		$UpwardSprite.visible = not $UpwardSprite.visible
		$DownwardCollisionShape.disabled = not $DownwardCollisionShape.disabled
		$DownwardSprite.visible = not $DownwardSprite.visible

	move_and_slide()
	position.x = wrapf(position.x, -2250, 2250)
	draw_ent()

func draw_ent():
	if left_entangled:
		$ent_left.visible = true
	else:
		$ent_left.visible = false
		
	if right_entangled:
		$ent_right.visible = true
	else:
		$ent_right.visible = false


func _on_timer_timeout() -> void:
	var new_projectile = projectile.instantiate()
	var sign = -1
	if not look_up:
		sign = 1
	new_projectile.position = position + Vector2(0,  sign * 115)
	new_projectile.up = -sign
	if sign == 1 :
		new_projectile.rotate(PI)
	get_tree().root.add_child(new_projectile)

func _take_damage() -> void:
	timer.stop()
	self.hide()
	$DownwardCollisionShape.disabled = true
	$UpwardCollisionShape.disabled = true
	alice_death.play()
	await alice_death.finished
	player_list.player_kill(self)
