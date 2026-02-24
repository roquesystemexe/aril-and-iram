extends CharacterBody2D

@export var gravity: float = 10.0;
@export var speed: float = 200.0;
@export var jump_force: float = 2.7;
@export var dash_force: float = 15.0;
@export var dash_cooldown: int = 65;
var dCooldown = 0;
var input_handler := InputHandler.new();

func _physics_process(delta: float) -> void:
	var input := input_handler.get_move();
	
	#==================================================== Horizontal Movement
	velocity.x = input.x * speed;
	
	if (dCooldown > 0):
		dCooldown -= 1;
	
	#==================================================== Dashing
	if (input_handler.get_dash() && dCooldown == 0):
		if velocity.x < 0:
			velocity.x -= dash_force * 300;
			dCooldown = dash_cooldown;
		else:
			velocity.x += dash_force * 300;
			dCooldown = dash_cooldown;
	
	#==================================================== Gravity & Jumping
	if not is_on_floor():
		velocity.y += gravity * delta * 300;
	else:
		if input_handler.get_jump():
			velocity.y -= jump_force * 300;
		else:
			velocity.y = 0.0;

	move_and_slide();
#
