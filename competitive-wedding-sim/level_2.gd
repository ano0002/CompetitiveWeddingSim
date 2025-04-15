extends Node3D

@onready var task_manager = $TaskManager

func _ready():
	var task_ui = preload("res://TaskManager.tscn").instantiate()
	add_child(task_ui)
	var level_tasks = {
		"1": {"text": "Réparer la radio", "completed": false},
		"2": {"text": "Arroser les plantes", "completed": false},
		"3": {"text": "Préparer à manger", "completed": false},
		"4": {"text": "Nétoyer le sol", "completed": true}
		}
	task_manager.set_tasks(level_tasks)
	
	# Wait 2 seconds then complete task 2
	await get_tree().create_timer(2.0).timeout
	task_manager.complete_task("3")

# Example function to complete a task
func _on_task_triggered():
	task_manager.complete_task("1")
