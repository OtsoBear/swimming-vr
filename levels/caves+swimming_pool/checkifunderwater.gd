extends CollisionShape3D

# Add the import statement for the CollisionShape3D class
extends CollisionShape3D

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_layer = 1  # Set the collision layer directly

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if has_overlapping_areas() == True:
		print("Overlapping")
