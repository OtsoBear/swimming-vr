@tool
class_name XRMovementSwim
extends XRToolsMovementProvider

## Movement provider order
@export var order : int = 10

var speed : int = 12

var jitter_comp : int = 5

var drag_coefficient: float = 0000.11

var speed_treshold: float = 0.014


# Controller node
@onready var _controller := XRHelpers.get_xr_controller(self)

@onready var _bodyCamera := XRHelpers.get_xr_camera(self)

@onready var lastposition := _controller.position.normalized()

@onready var velocity := Vector3(0,0,0)


# Add support for is_xr_class on XRTools classes
func is_xr_class(name : String) -> bool:
	return name == "XRToolsMovementDirect" or super(name)

# Swims
func physics_movement(_delta: float, player_body: XRToolsPlayerBody, _disabled: bool):
	# Skip if the controller isn't active
	if !_controller.get_is_active():
		return
		
	
	if (!get_relative_position(_controller.global_position).distance_to(lastposition) < speed_treshold) && isInWater(_controller.global_position):
		var controller_movement_direction = lastposition.normalized().direction_to(get_relative_position(_controller.global_position).normalized())
		
		DebugDraw3D.draw_line(_controller.global_position, _controller.global_position + controller_movement_direction * 0.3, Color(0,1,0))
		
		velocity += (controller_movement_direction * _delta * clampf(_controller.global_position.distance_squared_to(_bodyCamera.global_position), 0, 1.0) * speed * -1)
	
	var rel_pos = get_relative_position(_controller.global_position)
	
	
	
	if isInWater(_bodyCamera.global_position - Vector3.UP * 0.4):
		# applies drag
		velocity +=  -velocity.normalized() * (drag_coefficient * (((velocity.length() * 0.8) ** 2)/2))
		# Applies buyoncy
		velocity += (Vector3.UP * 0.0006)
		
	else:
		velocity += Vector3.DOWN * 0.981 * _delta
	
	print(velocity)
	
	player_body.move_body(velocity)
	lastposition = get_relative_position(_controller.global_position)



func isInWater(transform: Vector3) -> bool:
	if transform.y > 0:
		return false;
	return true

func get_relative_position(transform: Vector3) -> Vector3:
	return( transform - (_bodyCamera.global_position - (Vector3.UP * 0.2)))

# This method verifies the movement provider has a valid configuration.
func _get_configuration_warnings() -> PackedStringArray:
	var warnings := super()

	# Check the controller node
	if !XRHelpers.get_xr_controller(self):
		warnings.append("This node must be within a branch of an XRController3D node")

	# Return warnings
	return warnings
