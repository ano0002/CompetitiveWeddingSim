extends CharacterBody3D 

@export var speed = 6.0

func _init():
	pass

func _physics_process(delta):
	var temp_vel = Input.get_vector("move_left", "move_right", "move_back", "move_forward") * speed
	velocity = Vector3(temp_vel.x, 0, -temp_vel.y)
	move_and_slide()
	if velocity != Vector3(0,0,0):
		rotation.y = Vector2(velocity.x, -velocity.z).angle()+90
