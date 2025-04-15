extends Node

var tasks = {}
var task_labels = {}

@onready var task_container = $CanvasLayer/TaskListContainer



func set_tasks(new_tasks: Dictionary):
    tasks = new_tasks.duplicate()

    for child in task_container.get_children():
        child.queue_free()

    task_labels.clear()

    for id in tasks.keys():
        var task = tasks[id]
        var label = Label.new()

        # Format: dot if not completed, checkmark if completed
        if task["completed"]:
            label.text = "✔ " + task["text"]
            label.modulate = Color.DARK_GREEN
        else:
            label.text = "• " + task["text"]
            label.modulate = Color.BLACK

        # Styling
        label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
        label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
        label.set("theme_override_fonts/font", load("res://Assets/Fonts/Morning Bright.otf"))
        task_container.add_child(label)
        task_labels[id] = label

func complete_task(task_id: String):
    if tasks.has(task_id):
        tasks[task_id]["completed"] = true

        var label = task_labels.get(task_id)
        if label:
            label.text = "✔ " + tasks[task_id]["text"]
            label.modulate = Color.DARK_GREEN
