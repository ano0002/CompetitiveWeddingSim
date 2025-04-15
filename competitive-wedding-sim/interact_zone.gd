extends Area3D

var players_in = []

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	for player in players:
		player.interact_signal.connect(self._on_interact)
	self.body_entered.connect(self._on_body_entered)
	self.body_exited.connect(self._on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("players"):
		players_in.append(body)

func _on_body_exited(body):
	if body.is_in_group("players"):
		players_in.erase(body)

func _on_interact(player_num):
	for player in players_in:
		if player.player_num == player_num:
			print("Interacting with player: ", player_num)
			break
