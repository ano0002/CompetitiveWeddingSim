extends CharacterBody3D 

@export var speed = 4.5
@export var player_num = 1
@export var dash_mult = 3.5

var dash_dir = Vector2(0, 0)
var is_dashing = 0

var can_interact = 0

signal interact_signal(player_num)

var animation_player : AnimationPlayer
var particle_generator : GPUParticles3D
var camera : Camera3D
var pick_up_display : MeshInstance3D

var holded : Node3D = null

func _init():
	pass

func _ready():
	animation_player = get_node("character_model/AnimationPlayer")
	animation_player.play("idle")
	
	particle_generator = get_node("ParticleGenerator")

	camera = owner.get_node("Camera3D")

	pick_up_display = get_node("PickUpDisplay")

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
		if can_interact > 0:
			# Call the interact signal
			interact_signal.emit(player_num)
		elif holded != null:
			drop()

	elif event.is_action_pressed("dash_"+str(player_num)):
		is_dashing = 5
		dash_dir = Input.get_vector("move_left_"+str(player_num), "move_right_"+str(player_num), "move_back_"+str(player_num), "move_forward_"+str(player_num)) * speed * dash_mult

func pick_up(body):
	if holded != null:
		drop()
	holded = body
	print(holded)
	pick_up_display.show()


func drop():
	holded.dropped(self.position + Vector3(0,0,1).rotated(Vector3(0, 1, 0), rotation.y))
	holded = null
	pick_up_display.hide()

func add_interact_zone():
	can_interact += 1

func remove_interact_zone():
	can_interact -= 1
	if can_interact < 0:
		can_interact = 0
