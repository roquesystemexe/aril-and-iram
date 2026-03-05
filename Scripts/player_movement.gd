extends CharacterBody2D
class_name PlayerMovement

@export var gravity: float = 10.0;
@export var speed: float = 125.0;
@export var jump_force: float = 135.0;
@export var dash_force: float = 300.0;
@export var dash_cooldown: int = 65;
@export var double_jump: bool = true;
var dCooldown = 0;
var input_handler := InputHandler.new();
var direction = 1;

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta * 100;
	if velocity.x > 0:
		direction = 1;
	elif velocity.x < 0:
		direction = -1;
	
	var input := input_handler.get_move();
	
	#==================================================== Gravity
	velocity.x = input.x * speed;
	
	#==================================================== Horizontal Movement
	
	if (dCooldown > 0):
		dCooldown -= 1;
	
	#==================================================== Dashing
	if (input_handler.get_dash() and dCooldown == 0):
		if velocity.x < 0:
			velocity.x = dash_force * delta * -500;
			dCooldown = dash_cooldown;
		else:
			velocity.x = dash_force * delta * 500;
			dCooldown = dash_cooldown;
	
	#==================================================== Jumping
	if is_on_floor():
		double_jump = true;
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
	elif double_jump:
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
			double_jump = false;


	move_and_slide();
#
