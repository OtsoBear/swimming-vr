extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = "res://sounds/kultakatriina.mp3"
		$AudioStreamPlayer2D.play()
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = "res://sounds/avaimen heittohuuto (ehkä).mp3"
			$AudioStreamPlayer2D.play()
			if !$AudioStreamPlayer2D.is_playing():
				$AudioStreamPlayer2D.stream = "res://sounds/plums, avaimet menee veteen.mp3"
				$AudioStreamPlayer2D.play()
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
