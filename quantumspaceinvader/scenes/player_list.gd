extends Node2D

var preload_qubits = preload("res://scenes/player.tscn")
@onready var og_player: CharacterBody2D = $Player
@onready var player_list = [og_player]
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
	
func player_add(player_neighboor, cnot_lenght, left = true):
	
	var new_player = preload_qubits.instantiate()
	new_player.global_position.x = player_neighboor.global_position.x + cnot_lenght
	new_player.global_position.y = player_neighboor.global_position.y
	new_player.playerID = curr_player_id
	curr_player_id += 1
	
	if left:
		player_neighboor.left_entangled = true
		new_player.right_entangled = true
		new_player.position.x *= -1
		player_list.push_front(new_player)
	else:
		player_neighboor.right_entangled = true
		new_player.left_entangled = true
		player_list.push_back(new_player)
	
	self.call_deferred("add_child", new_player)
	
	
func player_kill(player_id):
	var player_index = find_player_index(player_id)
	if player_index == -1:
		print("Player not found")
		return
	if player_index == 0 and len(player_list) > 1:
		player_list[1].left_entangled = false 
	elif len(player_list) > 1 and player_index == len(player_list) - 1:
		player_list[len(player_list) - 1].left_entangled = false
		
	player_list[player_index].call_deferred("queue_free")
	player_list.remove_at(player_index)
	
	
			
			
	
