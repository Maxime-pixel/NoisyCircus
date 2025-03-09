extends Node2D
@onready var game_over: Node2D = $GameOver

@onready var player_list: Node2D = %PlayerList


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	if len(player_list.get_children()) == 0:
		game_over.visible = true
		
func _on_quit_game_pressed() -> void:
	
	get_tree().quit()
	
	
	
	
	
	
	
	
