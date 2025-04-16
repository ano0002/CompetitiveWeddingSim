extends Control

@onready var progress_bar = $ProgressBar

func _on_ready() -> void:
	%"Button Return".grab_focus()


var max_time = 0

func _on_button_return_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LevelSelector/level_selector.tscn")
	
func _on_button_quit_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	max_time = global.max_time[global.current_level]
	
	var percentage = (global.temp_time / max_time) * 100
	progress_bar.set_value(percentage)
