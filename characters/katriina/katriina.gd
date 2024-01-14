extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("Playing Sound")
	if !$AudioStreamPlayer3D.is_playing():
		$AudioStreamPlayer3D.stream = load("res://sounds/kultakatriina.mp3")
		$AudioStreamPlayer3D.play()
		if !$AudioStreamPlayer3D.is_playing():
			$AudioStreamPlayer3D.stream = load("res://sounds/avaimen heittohuuto (ehkä).mp3")
			$AudioStreamPlayer3D.play()
			if !$AudioStreamPlayer3D.is_playing():
				$AudioStreamPlayer3D.stream = load("res://sounds/plums, avaimet menee veteen.mp3")
				$AudioStreamPlayer3D.play()
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
