extends Node
class_name InputHandler

func _restart() -> bool:
	if Input.is_action_just_pressed("restart"):
		GameManager.has_checkpoint = false;
		GameManager.dJump_enabled = false;
		return true;
	else:
		return false;

func _quit() -> bool:
	if Input.is_action_just_pressed("quit"):
		return true;
	return false;

func get_move() -> Vector2:
	var dir := Vector2.ZERO
	if Input.is_action_pressed("move_right"):				# RIGHT INPUT
		dir.x += 1
	if Input.is_action_pressed("move_left"):				# LEFT INPUT
		dir.x -= 1
	return dir.normalized();
	
func get_jump() -> bool:
	if Input.is_action_just_pressed("jump"):				# JUMP INPUT
		return true;
	else:
		return false;
func get_dash() -> bool:
	if Input.is_action_just_pressed("dash"):				# DASH INPUT
		return true;
	else:
		return false;
