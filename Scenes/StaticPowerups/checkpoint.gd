extends Area2D
func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		GameManager.checkpoint_djump = GameManager.dJump_enabled
		GameManager.respawn_point = global_position
		GameManager.has_checkpoint = true
