extends CharacterBody2D

enum EnemyType { GOOBER, SPEARMAN }
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Hitbox

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("player")

# ================================ TEXTURES =========================== #
@export var goober_texture: Texture2D 									#
@export var spearman_texture: Texture2D									#
# ===================================================================== #

var can_attack := true
var attack_cooldown := 0.0
var cooldown_left := 0.0
const SPEED = 125.0
const JUMP_VELOCITY = -250.0



func _physics_process(delta: float) -> void:
	if !can_attack:
		cooldown_left = max(cooldown_left - delta, 0.0)
	
	
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
