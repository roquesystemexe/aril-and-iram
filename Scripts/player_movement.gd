extends CharacterBody2D

@export var gravity = 10;
@export var speed = 100;
var is_falling: bool = false;


func _move(body: CharacterBody2D, direction: float) -> void:
	body.velocity.x = direction * speed;
	
func handle_gravity(body: CharacterBody2D, delta: float) -> void:
	if not body.is_on_floor():
		body.velocity.y += gravity * delta;
	is_falling = body.velocity.y > 0 and not body.is_on_floor();

func _physics_process(delta: float) -> void:
	handle_gravity(self, delta);


func _process(delta: float) -> void:
	
	pass
