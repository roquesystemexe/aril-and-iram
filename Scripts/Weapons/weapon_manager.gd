extends Node2D
class_name WeaponManager

enum WeaponType { NONE, TOOTHPICK, AXE, MACE }

@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: Area2D = $Hitbox
@onready var collision: CollisionShape2D = $Hitbox/CollisionShape2D
@onready var cooldown_timer: Timer = $CooldownTimer
@onready var preview: Node2D = $AttackPreview

# 🔥 IMPORTANT: who is using this weapon (player or enemy)
var attacker: CharacterBody2D

@export var none_texture: Texture2D
@export var toothpick_texture: Texture2D
@export var axe_texture: Texture2D
@export var mace_texture: Texture2D

@export var attack_range := 120.0
@export var toothpick_cooldown := 0.2
@export var axe_cooldown := 0.6
@export var mace_cooldown := 1.5

var hit_targets: Array = []

var weapon_type: WeaponType
var can_attack := true

var cooldown_time := 0.0
var cooldown_left := 0.0

var impact_point: Vector2
var last_attack_rotation := 0.0
var idle_rotation := 0.0


func _ready():
	hitbox.monitoring = false
	hitbox.body_entered.connect(_on_hit_enter)
	hitbox.body_exited.connect(_on_hit_exit)
	update_weapon()


func _process(delta):
	if !can_attack:
		cooldown_left = max(cooldown_left - delta, 0.0)


# --------------------------------------------------
# ATTACKER SETUP
# --------------------------------------------------
func set_attacker(new_attacker: CharacterBody2D):
	attacker = new_attacker


# --------------------------------------------------
# HIT TRACKING
# --------------------------------------------------
func _on_hit_enter(body: CharacterBody2D):
	if body == attacker:
		return
	if attacker.is_in_group("enemies") and body.is_in_group("enemies"):
		return

	if attacker.is_in_group("player") and body.is_in_group("player"):
		return
	
	if body.has_method("take_damage"):
		hit_targets.append(body)


func _on_hit_exit(body):
	if body.has_method("take_damage"):
		hit_targets.erase(body)


# --------------------------------------------------
# WEAPON TYPE
# --------------------------------------------------
func set_weapon_type(new_type: WeaponType):
	weapon_type = new_type
	update_weapon()


func update_weapon():
	match weapon_type:
		WeaponType.NONE:
			sprite.texture = none_texture

		WeaponType.TOOTHPICK:
			sprite.texture = toothpick_texture

		WeaponType.AXE:
			sprite.texture = axe_texture

		WeaponType.MACE:
			sprite.texture = mace_texture


# --------------------------------------------------
# ATTACK CORE (NOW ATTACKER-BASED)
# --------------------------------------------------
func attack(target_position: Vector2):
	if !can_attack or attacker == null:
		return

	can_attack = false

	var origin = attacker.global_position
	var to_target = target_position - origin

	var direction = to_target.normalized()
	var clamped_distance = min(to_target.length(), attack_range)

	impact_point = origin + direction * clamped_distance
	last_attack_rotation = direction.angle()

	global_rotation = last_attack_rotation
	sprite.flip_v = direction.x < 0

	match weapon_type:
		WeaponType.TOOTHPICK:
			cooldown_time = toothpick_cooldown
			_toothpick_attack()

		WeaponType.AXE:
			cooldown_time = axe_cooldown
			_axe_attack()

		WeaponType.MACE:
			cooldown_time = mace_cooldown
			_mace_attack()

	cooldown_left = cooldown_time
	cooldown_timer.start(cooldown_time)

	show_attack_preview()


# --------------------------------------------------
# ATTACK TYPES
# --------------------------------------------------
func _toothpick_attack():
	var shape = RectangleShape2D.new()
	shape.size = Vector2(50, 10)

	collision.shape = shape
	hitbox.global_position = impact_point
	hitbox.global_rotation = global_rotation

	_enable_hitbox(0.1, 10)


func _axe_attack():
	var shape = RectangleShape2D.new()
	shape.size = Vector2(90, 40)

	collision.shape = shape
	hitbox.global_position = impact_point
	hitbox.global_rotation = global_rotation

	_enable_hitbox(0.25, 30)


func _mace_attack():
	var shape = CircleShape2D.new()
	shape.radius = 100

	collision.shape = shape
	hitbox.global_position = impact_point
	hitbox.global_rotation = global_rotation

	_enable_hitbox(0.4, 50)


# --------------------------------------------------
# HIT RESOLUTION
# --------------------------------------------------
func _enable_hitbox(duration: float, damage: int):
	var final_damage = damage

	if attacker != null and attacker.is_in_group("enemy"):
		final_damage = int(damage * 0.1)  # 40% enemy damage
	hitbox.monitoring = true

	await get_tree().create_timer(duration).timeout

	for target in hit_targets:
		if target != null:
			target.take_damage(final_damage)

	hitbox.monitoring = false
	hit_targets.clear()

	global_rotation = idle_rotation
	sprite.flip_v = false


# --------------------------------------------------
# COOLDOWN
# --------------------------------------------------
func _on_cooldown_timer_timeout():
	can_attack = true


func get_cooldown_progress() -> float:
	if cooldown_time == 0:
		return 0.0
	return cooldown_left / cooldown_time


# --------------------------------------------------
# VISUAL PREVIEW (PLAYER ONLY OPTIONAL)
# --------------------------------------------------
func show_attack_preview():
	if attacker != null and attacker.is_in_group("enemy"):
		return # enemies don't need preview UI

	preview.visible = true
	preview.global_position = impact_point
	preview.global_rotation = global_rotation

	match weapon_type:
		WeaponType.TOOTHPICK:
			preview.scale = Vector2(0.4, 0.2)

		WeaponType.AXE:
			preview.scale = Vector2(1.2, 0.6)

		WeaponType.MACE:
			preview.scale = Vector2(1.8, 1.0)

	await get_tree().create_timer(0.08).timeout
	preview.visible = false
