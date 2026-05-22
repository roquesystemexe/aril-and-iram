extends CharacterBody2D
class_name PlayerMovement


@export var gravity: float = 10.0;			# Base gravity
@export var speed: float = 125.0;			# Base speed
@export var jump_force: float = 135.0;		# Base jump force
@export var dash_force: float = 300.0;		# Base dash force
@export var dash_cooldown: int = 65;		# Base cooldown for dash 
@export var double_jump: bool = false;		# Double Jump Checker
@export var dash: bool = false;				# Dash Checker
var dCooldown = 0;
var input_handler := InputHandler.new();
var direction = 1;

func _ready() -> void:
	# Sync the player state with the GameManager when the level starts
	double_jump = GameManager.dJump_enabled
	dash = GameManager.dash_enabled

func _physics_process(delta: float) -> void:
	if velocity.x > 0:
		direction = 1;
	elif velocity.x < 0:
		direction = -1;
	
	var input := input_handler.get_move();
	
	#==================================================== Gravity
	velocity.y += gravity * delta * 100;
	
	#==================================================== Horizontal Movement
	velocity.x = input.x * speed;
	
	#==================================================== Dashing
	if (dCooldown > 0):
		dCooldown -= 1;
	
	if (input_handler.get_dash() and dCooldown == 0 and GameManager.dash_enabled):
		velocity.x = dash_force * delta * 500 * direction;
		dCooldown = dash_cooldown;
	
	#==================================================== Jumping
	if is_on_floor():
		if GameManager.dJump_enabled:
			double_jump = true;
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
	elif double_jump:
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
			double_jump = false;


	move_and_slide();
	
	input_handler.get_interact()
