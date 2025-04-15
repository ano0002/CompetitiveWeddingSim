extends Node3D

var default_owner = null
var players_in = []

@export var accepted: Array[String] = ["Lambda"]
@export var space: int = 1

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	for player in players:
		player.interact_signal.connect(self._on_interact)

	default_owner = get_parent()

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
			print(player.holded)
			if player.holded != null:
				print("Trying to store "+player.holded.item_name)
				print("Space: "+str(space))
				print("Accepted: "+str(accepted))
				if player.holded.item_name in accepted and space > 0:
					print("Stored "+player.holded.item_name) 
					player.holded.stored()
					player.drop()
					space -= 1
