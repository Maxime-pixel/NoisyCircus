extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var player_list = [player]
var rng = RandomNumberGenerator.new()

func get_random_player()-> CharacterBody2D:
	var player_list = get_children()
	if len(player_list) == 0:
		return
	return player_list[rng.randi_range(0, len(player_list) - 1)]
