extends Node3D

var default_owner = null
var players_in = []

@export_group("Items")
@export var allowed: Array[String] = ["Lambda"]
@export var need_item: bool = false
@export var destroy_item_on_complete: bool = false

@export_group("Self")
@export var space: int = 1
@export var destroy_self_on_complete: bool = false
@export var task_duration: float = 1.0
@export var reset_on_release: bool = true

var is_being_used = false
var interacted_time = 0.0
var interacting_player = null

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
			if (player.holded != null and player.holded.item_name in allowed and need_item) or not need_item:
				player.start_use(self)
				is_being_used = true
				interacting_player = player

func _process(delta: float) -> void:
	if is_being_used:
		interacted_time += delta
		if interacted_time >= task_duration:
			is_being_used = false
			interacted_time = 0.0
			interacting_player.unfreeze()
			if destroy_item_on_complete:
				interacting_player.destroy_holded()
			if destroy_self_on_complete:
				self.queue_free()

func stopped():
	is_being_used = false
	if reset_on_release:
		interacted_time = 0.0
