extends Node3D

@export var item_name: String = "Lambda"

var default_owner = null
var players_in = []

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
			player.pick_up(self)
			self.disable()
			break

func pick_up(body):
	reparent(body.get_node("PickUpDisplay"))
	position = Vector3(0, 0, 0)

func dropped(drop_pos):
	reparent(default_owner)
	position = drop_pos
	self.enable()

func stored():
	self.disable()
	self.hide()

func enable():
	get_node("Solid/CollisionShape3D").disabled = false
	get_node("InteractZone/CollisionArea").disabled = false

func disable():
	get_node("Solid/CollisionShape3D").disabled = true
	get_node("InteractZone/CollisionArea").disabled = true
