extends AnimatableBody3D

var underwater_envireoment = preload("res://characters/player/underwater_envireoment.tres")
var normal_envireoment = preload("res://characters/player/normal_envireoment.tres")

var oxygen_amount := 100.0

var inside_oxygen_pocket := false

var bodies = {}

@export var progress_bar: ProgressBar
@export var camera: Camera3D

@onready var last_position = position

func _process(delta):
	if isInWater(self.global_position):
		camera.set_environment(underwater_envireoment)
		oxygen_amount -= 3 * delta
	else:
		camera.set_environment(normal_envireoment)
		oxygen_amount = 100
	
	progress_bar.value = oxygen_amount

func _physics_process(delta):
	
	for body in bodies:
		print(instance_from_id(body).position)
		print(last_position.direction_to(position))
		instance_from_id(body).position += (last_position.direction_to(position))
		
	last_position = position

func isInWater(transform: Vector3) -> bool:
	if transform.y > 0:
		return false;
	
	return !inside_oxygen_pocket

func enter_oxygen_pocket():
	inside_oxygen_pocket = true
	
func exit_oxygen_pocket():
	inside_oxygen_pocket = false


func _on_inventory_body_entered(body: Node3D):
	if body.get_class() == "RigidBody3D":
		body.freeze = true
		bodies[body.get_instance_id()] = body.get_instance_id()


func _on_inventory_body_exited(body: Node3D):
	if body.get_class() == "RigidBody3D":
		body.freeze = false
		bodies.erase(body.get_instance_id())
