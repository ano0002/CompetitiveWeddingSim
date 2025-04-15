extends Node3D

var players_in = []

@export var task_name: String = "Storage Task"

@export var accepted: Array[String] = ["Lambda"]
@export var space: int = 1

var task_manager: Node = null

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	for player in players:
		player.interact_signal.connect(self._on_interact)

	task_manager = %TaskManager

func _on_body_entered(body):
	if body.is_in_group("players"):
		players_in.append(body)
		body.add_interact_zone()

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_in.erase(body)
		body.remove_interact_zone()

func _on_interact(player_num):
	for player in players_in:
		if player.player_num == player_num:
			if player.holded != null:
				if player.holded.item_name in accepted and space > 0:
					player.holded.stored()
					player.drop()
					space -= 1
					if task_manager != null:
						task_manager._on_task_progress(task_name)
