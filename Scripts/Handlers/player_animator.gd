extends Node2D
class_name PlayerAnimator
@export var player_movement : PlayerMovement
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(_delta: float) -> void:
	# ======================================================= Flipping the character Horizontally
	if player_movement.direction == 1:
		sprite.flip_h = false;
	elif player_movement.direction == -1:
		sprite.flip_h = true;
	
	# ======================================================= Playing the animations
	if abs(player_movement.velocity.x) > 0.0: # ============= X
		animation_player.play("move");
	else:
		animation_player.play("idle");
		
	if player_movement.velocity.y < 0.0: # ================== Y
		animation_player.play("jump");
	elif player_movement.velocity.y > 0.0:
		animation_player.play("fall");
