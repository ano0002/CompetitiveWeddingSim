extends Control

func _ready() -> void:
	$"buttons/VBoxContainer/Button Play".grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/LevelSelector/level_selector.tscn")

func _on_option_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/SettingsMenu/setting_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit() 
