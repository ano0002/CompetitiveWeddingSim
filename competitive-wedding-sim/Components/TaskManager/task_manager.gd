extends Node3D

@export var tasks_names: Array[String] = ["test task 1", "test task 2", "test task 3"]
@export var tasks_needed_repeats: Array[int] = [1, 4, 2]

var tasks_completed: Array[int] = []

@onready var task_container = $CanvasLayer/TaskListContainer

func _ready():
    for i in range(tasks_names.size()):
        generate_task(tasks_names[i], tasks_needed_repeats[i])
        tasks_completed.append(0)
    

func generate_task(t_name: String, repeat: int):
    # Create a new label
    var label = Label.new()
    label.text = "• " + t_name + " (0/" + str(repeat) + ")"
    label.modulate = Color.BLACK
    label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
    label.set("theme_override_fonts/font", load("res://Assets/Fonts/Morning Bright.otf"))
    task_container.add_child(label)

func _on_task_progress(t_name: String):
    var index = tasks_names.find(t_name)
    # Find the task label
    var label = task_container.get_child(index)
    # Update the label text
    tasks_completed[index] += 1
    # Check if the task is completed
    if tasks_completed[index] >= tasks_needed_repeats[index]:
        label.text = "✔ " + t_name + " (" + str(tasks_completed[index]) + "/" + str(tasks_needed_repeats[index]) + ")"
        label.modulate = Color.DARK_GREEN

        # Emit signal to notify task completion
        emit_signal("task_completed", t_name)

    else:
        label.text = "• " + t_name + " (" + str(tasks_completed[index]) + "/" + str(tasks_needed_repeats[index]) + ")"
        label.modulate = Color.BLACK
