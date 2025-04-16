extends Node3D

@onready var timer = $GameTimer
@onready var label = $TimerLabel
var countdown : int = 45

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer.start() 

func _on_timer_timeout():
	countdown -= 1
	label.text = "Time Left: %d" % countdown
	if countdown <= 0:
		timer.stop()
		label.text = "Time's up!"
