extends Area2D
var player_movement := PlayerMovement.new();
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_movement.dCooldown = 0;
		if GameManager.has_checkpoint:
			GameManager.dJump_enabled = GameManager.checkpoint_djump
			body.global_position = GameManager.respawn_point
			body.velocity = Vector2.ZERO
		else:
			GameManager.dJump_enabled = false;
			get_tree().reload_current_scene()
