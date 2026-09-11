extends CharacterBody2D
class_name PlayerMovement

@onready var weapon: WeaponManager = $PlayerWeapon
@export var gravity: float = 10.0;			# Base gravity
@export var speed: float = 125.0;			# Base speed
@export var jump_force: float = 135.0;		# Base jump force 135
@export var dash_force: float = 300.0;		# Base dash force
@export var dash_cooldown: int = 65;		# Base cooldown for dash 
@export var double_jump: bool = false;		# Double Jump Checker
@export var dash: bool = false;				# Dash Checker
var dCooldown = 0;							# Dash Cooldown
var input_handler := InputHandler.new();
var direction = 1;
var weapon_index := 0

var weapon_order := [
	WeaponManager.WeaponType.NONE,
	WeaponManager.WeaponType.TOOTHPICK,
	WeaponManager.WeaponType.AXE
]




func _ready() -> void:
	# Sync the player state with the GameManager when the level starts
	double_jump = GameManager.dJump_enabled
	dash = GameManager.dash_enabled
	apply_weapon(weapon_index)

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
	var i_frames := 1000;
	if is_on_floor():
		i_frames = 50;
	elif i_frames > 0:
		i_frames =- 1;

	if is_on_floor():
		if GameManager.dJump_enabled:
			double_jump = true;
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
	elif double_jump:
		if input_handler.get_jump():
			velocity.y -= jump_force * delta * 100;
			double_jump = false;

	#==================================================== Weapon Equipping
	if input_handler.get_weapon_selection() != 0:
		var sel := input_handler.get_weapon_selection()
		#print("Weapon selection raw: ", sel)
		apply_weapon(sel - 1)



	move_and_slide();
	input_handler.get_interact()

func apply_weapon(weapon_ind: int) -> void:
	if weapon_ind >= weapon_order.size():
		weapon_ind = 0

	weapon_index = weapon_ind
	weapon.set_weapon_type(weapon_order[weapon_index])
	GameManager.curr_weapon = weapon_order[weapon_index]
