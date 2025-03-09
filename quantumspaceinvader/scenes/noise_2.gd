extends Area2D

const SPEED = 400
var sign = 1
var player
var norm

var rng = RandomNumberGenerator.new()
var CXCHANCES = 1
var preload_cnot = preload("res://scenes/cnot.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	var difference = position - player.position
	rotate(difference.angle() + 3.14)
	norm = difference.normalized()

func _physics_process(delta: float) -> void:
	position.x -= norm.x * delta * SPEED
	position.y -= norm.y * delta * SPEED
	if position.x > 2500 or position.x < -2500 or position.y > 1500 or position.y < -1500 :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	body._take_damage()

func destroy():
	var rng_val = rng.randi_range(0, CXCHANCES)
	if rng_val == 0:
		var cnot_node = preload_cnot.instantiate()
		cnot_node.position = position
		if position.y > player.position.y:
			sign = -1
		cnot_node.SPEED = cnot_node.SPEED * sign
		get_tree().current_scene.call_deferred("add_child", cnot_node)
	audio_stream_player_2d.play()
	await audio_stream_player_2d.finished
	self.queue_free()
	
