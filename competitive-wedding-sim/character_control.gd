extends CharacterBody3D 

@export var speed = 4.5
@export var player_num = 1
@export var dash_mult = 3.5

var dash_dir = Vector2(0, 0)
var is_dashing = 0

signal interact_signal(player_num)

var animation_player : AnimationPlayer
var particle_generator : GPUParticles3D
var camera : Camera3D

func _init():
	pass

func _ready():
	animation_player = get_node("character_model/AnimationPlayer")
	animation_player.play("idle")
	
	particle_generator = get_node("ParticleGenerator")

	camera = owner.get_node("Camera3D")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "idle":
		animation_player.play("idle")
	elif anim_name == "walk":
		animation_player.play("walk")
	elif anim_name == "sprint":
		animation_player.play("sprint")

func _physics_process(_delta):
	var camera_rotation_y = camera.get_rotation().y
	var temp_vel = Input.get_vector("move_left_"+str(player_num), "move_right_"+str(player_num), "move_back_"+str(player_num), "move_forward_"+str(player_num)) * speed
	# Adjust to camera rotation
	if is_dashing>0:
		temp_vel = dash_dir
	velocity = Vector3(temp_vel.x, 0, -temp_vel.y).rotated(Vector3(0, 1, 0), camera_rotation_y)
	move_and_slide()
	is_dashing = max(is_dashing - 1, 0)

	if velocity != Vector3(0,0,0):
		animation_player.play("sprint")
		rotation.y = Vector2(velocity.x, -velocity.z).angle()+90
		particle_generator.set_emitting(true)
		particle_generator.set_amount_ratio(velocity.length()/(speed*dash_mult))

	else:
		particle_generator.set_emitting(false)
		animation_player.play("idle")


func _input(event):
	if event.is_action_pressed("interact_"+str(player_num)):
		interact_signal.emit(player_num)
	elif event.is_action_pressed("dash_"+str(player_num)):
		is_dashing = 5
		dash_dir = Input.get_vector("move_left_"+str(player_num), "move_right_"+str(player_num), "move_back_"+str(player_num), "move_forward_"+str(player_num)) * speed * dash_mult
