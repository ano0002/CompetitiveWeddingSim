extends Control


func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LevelSelector/level_selector.tscn")
	
func _on_button_quit_pressed() -> void:
	get_tree().quit()
