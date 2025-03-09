extends Node2D

var preload_qubits = preload("res://scenes/player.tscn")
@onready var og_player: CharacterBody2D = $Player
@onready var player_list = [og_player]
@onready var ent_sprite = $"../entangle"
@onready var og_scale = ent_sprite.texture.get_width()

var rng = RandomNumberGenerator.new()
var curr_player_id = 0
func get_random_player()-> CharacterBody2D:
	var player_list = get_children()
	if len(player_list) == 0:
		return
	return player_list[rng.randi_range(0, len(player_list) - 1)]
	
func find_player_index(player_id):
	for index in len(player_list):
		if player_list[index].playerID == player_id:
			return index
	return -1
	
func _physics_process(delta: float) -> void:
	draw_ent()
	
func draw_ent():
	var players_list = get_children()
	
	if len(players_list) <= 1 :
		ent_sprite.scale.x = og_scale
		ent_sprite.visible = false
		$"../entangle_left".visible = false
		$"../entangle_right".visible = false
		return
		
	var start_pos = players_list[0].position
	var end_pos = players_list[-1].position
	#if (end_pos - start_pos).x < 0:
	#	$"../entangle_left".visible = true
	#	$"../entangle_left".position.x -= $"../entangle_left".texture.get_width() / 2
	#	$"../entangle_right".visible = true
	#	$"../entangle_right".position.x += $"../entangle_right".texture.get_width() / 2
	#	ent_sprite.visible = false

	$"../entangle_left".visible = false
	$"../entangle_right".visible = false
	# ent_sprite.texture.set_width(abs(end_pos - start_pos).x)
	ent_sprite.scale.x = (end_pos - start_pos).x / ent_sprite.texture.get_width()
	ent_sprite.visible = true
	ent_sprite.position.x = (end_pos + start_pos).x / 2
	
func player_add(player_neighboor, cnot_lenght, left):
	
	var new_player = preload_qubits.instantiate()
	new_player.global_position.x = player_neighboor.global_position.x

	new_player.global_position.y = player_neighboor.global_position.y
	new_player.playerID = curr_player_id
	curr_player_id += 1
	
	if left:
		new_player.global_position.x -= cnot_lenght
		player_list.push_front(new_player)
	else:
		new_player.global_position.x += cnot_lenght
		player_list.push_back(new_player)
	
	self.call_deferred("add_child", new_player)
	
func player_kill(player):
	player_list.remove_at(player_list.find(player))
	player.call_deferred("queue_free")

			
			
	
