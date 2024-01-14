extends Area3D

func _on_body_entered(body: Node3D):
	if body.has_method("enter_oxygen_pocket"):
		body.call("enter_oxygen_pocket")
	print("body_entered")


func _on_body_exited(body: Node3D):
	
	if body.has_method("exit_oxygen_pocket"):
		body.call("exit_oxygen_pocket")
