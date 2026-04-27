extends Area2D
var player_movement := PlayerMovement.new();
var dash_abil := DashAbil.new();
var djump_abil := DJumpAbil.new();

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		player_movement.dCooldown = 0;
		if GameManager.has_checkpoint:
			GameManager.dJump_enabled = GameManager.checkpoint_djump
			GameManager.dash_enabled = GameManager.checkpoint_dash
			body.global_position = GameManager.respawn_point
			body.velocity = Vector2.ZERO
			for item in get_tree().get_nodes_in_group("pickups"):
				# It checks the ID property on whatever script is attached to the node
				if !GameManager.is_item_collected(item.item_id):
					item.show()
					item.set_process(true)
					# Assuming your collision shape is in the same path for both
					var col = item.get_node_or_null("Area2D/CollisionShape2D")
					if col: col.disabled = false
		else:
			GameManager.dJump_enabled = false;
			GameManager.dash_enabled = false;
			player_movement.double_jump = false;
			get_tree().reload_current_scene()
