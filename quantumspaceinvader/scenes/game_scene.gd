extends Node2D


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()



func _on_quit_game_pressed() -> void:
	get_tree().quit()
