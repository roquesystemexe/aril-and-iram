extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		if GameManager.has_checkpoint:
			body.global_position = GameManager.respawn_point
			body.velocity = Vector2.ZERO
		else:
			get_tree().reload_current_scene()
