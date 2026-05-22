extends Node2D

@export var height := -100.0
@export var speed := 100.0

var is_inside := false
var moved := false
var move_cooldown := 0.0
var target_y := 0.0
var base_elevator_cooldown: int = 1000
var elevator_cooldown = 0

func _ready() -> void:
	target_y = position.y

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = false

func start_move() -> void:
	if !moved:								# Goes DOWN
		target_y = position.y + height
		moved = true
		elevator_cooldown = base_elevator_cooldown

	elif moved:									# Goes UP
		target_y = position.y - height
		moved = false
		elevator_cooldown = 0

func _process(delta: float) -> void:
	
	if move_cooldown > 0.0:
		move_cooldown -= delta
	if elevator_cooldown > 0:
		#print(elevator_cooldown)
		elevator_cooldown -= 1
	
	
	if moved and (elevator_cooldown == 0):
		start_move()

	if is_inside and GameManager.is_interacting and move_cooldown <= 0.0:
		start_move()
		move_cooldown = 2;

	position.y = move_toward(position.y, target_y, speed * delta)
