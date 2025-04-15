extends CharacterBody3D 

@export var speed = 6.0
@export var player_num = 1

signal interact_signal(player_num)

var animation_player : AnimationPlayer

func _init():
	pass

func _ready():

	animation_player = get_node("character_model/AnimationPlayer")
	animation_player.play("idle")
	# Loop the idle animation

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "idle":
		animation_player.play("idle")
	elif anim_name == "walk":
		animation_player.play("walk")
	elif anim_name == "sprint":
		animation_player.play("sprint")

func _physics_process(_delta):
	var temp_vel = Input.get_vector("move_left_"+str(player_num), "move_right_"+str(player_num), "move_back_"+str(player_num), "move_forward_"+str(player_num)) * speed
	velocity = Vector3(temp_vel.x, 0, -temp_vel.y)
	move_and_slide()
	if velocity != Vector3(0,0,0):
		animation_player.play("sprint")
		rotation.y = Vector2(velocity.x, -velocity.z).angle()+90
	else:
		animation_player.play("idle")

func _input(event):
	if event.is_action_pressed("interact_"+str(player_num)):
		interact_signal.emit(player_num)
