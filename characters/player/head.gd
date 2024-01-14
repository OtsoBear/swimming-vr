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
	if oxygen_amount < 10 && !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream = load("res://sounds/hukkuminen.mp3")
		%AudioStreamPlayer.play() 
		if !%AudioStreamPlayer.is_playing():
			%AudioStreamPlayer.stream = load("res://sounds/pool noodle.mp3")
			%AudioStreamPlayer.play()
	if oxygen_amount == 76 && !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream =load("res://sounds/murinaa (matala).mp3" )
		%AudioStreamPlayer.play()
	if oxygen_amount == 52 && !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream =load("res://sounds/katriina rummuttaa vihaisesti altaan reunalla.mp3")
		%AudioStreamPlayer.play()
	
	if oxygen_amount == 28 && !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream =  load("res://sounds/kupla 2.mp3")
		%AudioStreamPlayer.play()

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
	if !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream = load("res://sounds/kuplii.mp3")
		%AudioStreamPlayer.play()
	
func exit_oxygen_pocket():
	inside_oxygen_pocket = false

	if !%AudioStreamPlayer.is_playing():
		%AudioStreamPlayer.stream = load("res://sounds/vesi splash splash.mp3")
		%AudioStreamPlayer.play()


func _on_inventory_body_entered(body: Node3D):
	if body.get_class() == "RigidBody3D":
		body.freeze = true
		bodies[body.get_instance_id()] = body.get_instance_id()


func _on_inventory_body_exited(body: Node3D):
	if body.get_class() == "RigidBody3D":
		body.freeze = false
		bodies.erase(body.get_instance_id())
