extends Node

var h_input: float = 0.0
func _process(delta: float) -> void:
	h_input = Input.get_axis("move_left", "move_right");
func _getJump() -> bool:
	return Input.is_action_just_pressed("jump")
