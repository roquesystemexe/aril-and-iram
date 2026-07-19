extends CharacterBody2D
class_name AnvilMovement
@export var gravity: float = 10.0;			# Base gravity
var active: bool = false;
func _ready():
	$RayCast2D.add_exception(TileMapLayer)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $RayCast2D.is_colliding() && ($RayCast2D.get_collider() is CharacterBody2D):		#Background already has NO COLLISIONS
		#print($RayCast2D.get_collider())
		active = true
	if active:
		velocity.y += gravity * delta * 100;
	move_and_slide()
