extends Node3D

@onready var task_manager = $TaskManager

func _ready():
    var level_tasks = {
        "1": {"text": "Passer la tondeuse", "completed": false},
        "2": {"text": "Nourrir le chien", "completed": false},
        "3": {"text": "Tabasser les taupes", "completed": false},
        "4": {"text": "Juter les agneaux", "completed": true}
        }
    task_manager.set_tasks(level_tasks)
    
    # Wait 2 seconds then complete task 2
    await get_tree().create_timer(2.0).timeout
    task_manager.complete_task("3")

# Example function to complete a task
func _on_task_triggered():
    task_manager.complete_task("1")
