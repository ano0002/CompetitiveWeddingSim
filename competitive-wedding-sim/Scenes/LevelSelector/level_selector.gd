extends Control

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

@onready var info_label = $"Label Level Info"

# Level data dictionary
var level_data = {
	"Level1": {
		"name": "Level 1",
		"time": "0:45",
		"best_record": "NA"
	},
	"Level2": {
		"name": "Level 2",
		"time": "4:00",
		"best_record": "NA"
	},
	"Level3": {
		"name": "Level 3",
		"time": "5:00",
		"best_record": "NA"
	}
}

func _ready():
	
	$"Button Level 1".grab_focus()
	
	# Connect button signals for hover and unhover
	$"Button Level 1".mouse_entered.connect(func(): _on_level_hovered("Level1"))
	$"Button Level 1".mouse_exited.connect(_on_level_unhovered)
	$"Button Level 1".focus_entered.connect(func(): _on_level_hovered("Level1"))
	$"Button Level 1".focus_exited.connect(_on_level_unhovered)
	$"Button Level 1".pressed.connect(_on_button_level_1_pressed)

	$"Button Level 2".mouse_entered.connect(func(): _on_level_hovered("Level2"))
	$"Button Level 2".mouse_exited.connect(_on_level_unhovered)
	$"Button Level 2".focus_entered.connect(func(): _on_level_hovered("Level2"))
	$"Button Level 2".focus_exited.connect(_on_level_unhovered)
	$"Button Level 2".pressed.connect(_on_button_level_2_pressed)
	
	$"Button Level 3".mouse_entered.connect(func(): _on_level_hovered("Level3"))
	$"Button Level 3".mouse_exited.connect(_on_level_unhovered)
	$"Button Level 3".focus_entered.connect(func(): _on_level_hovered("Level3"))
	$"Button Level 3".focus_exited.connect(_on_level_unhovered)
	$"Button Level 3".pressed.connect(_on_button_level_3_pressed)

	
func _on_level_hovered(level_key: String) -> void:
	var data = level_data.get(level_key)
	if data != null:
		info_label.text = "Name : %s\nTime : %s\nBest Record : %s" % [
			data["name"],
			data["time"],
			data["best_record"]
		]

func _on_level_unhovered() -> void:
	info_label.text = "Name :\nTime :\nBest Record :"

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
	
func _on_button_level_1_pressed() -> void:
	global.current_level = "Lvl1"
	get_tree().change_scene_to_file("res://Scenes/Levels/Lvl1/level.tscn")

func _on_button_level_2_pressed() -> void:
	pass # Replace with function body.

func _on_button_level_3_pressed() -> void:
	pass # Replace with function body.
	
