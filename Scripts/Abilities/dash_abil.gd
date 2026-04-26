extends Area2D
var player_movement := PlayerMovement.new();
var input_handler := InputHandler.new();
var is_inside : bool = false;

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = true;

func _on_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		is_inside = false;
	
func _process(_delta: float) -> void:
	if (is_inside and GameManager.is_interacting):
		GameManager.dash_enabled = true;
		queue_free();
