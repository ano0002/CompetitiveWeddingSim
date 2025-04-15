extends RigidBody3D

func _on_body_entered(body):
    print("Body entered: ", body.name)
    if body.has_meta("Interactable") and body.get_meta("Interactable") == true:
        print('interactable')
        body.interact()
    # Check if the body has a method named "interact"
    if body.has_method("interact"):
        body.interact()
