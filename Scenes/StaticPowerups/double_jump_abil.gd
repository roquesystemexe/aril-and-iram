extends Area2D
var player_movement := PlayerMovement.new();
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.dJump_enabled = true;
		player_movement.double_jump = true;
		print(player_movement.double_jump)
