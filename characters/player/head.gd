extends AnimatableBody3D

var underwater_envireoment = preload("res://characters/player/underwater_envireoment.tres")
var normal_envireoment = preload("res://characters/player/normal_envireoment.tres")

var oxygen_amount := 100.0

var inside_oxygen_pocket := false

@export var progress_bar: ProgressBar
@export var camera: Camera3D

func _process(delta):
	if isInWater(self.global_position):
		camera.set_environment(underwater_envireoment)
		oxygen_amount -= 3 * delta
	else:
		camera.set_environment(normal_envireoment)
		oxygen_amount = 100
	
	progress_bar.value = oxygen_amount

func isInWater(transform: Vector3) -> bool:
	if transform.y > 0:
		return false;
	
	return !inside_oxygen_pocket

func enter_oxygen_pocket():
	inside_oxygen_pocket = true
	
func exit_oxygen_pocket():
	inside_oxygen_pocket = false
