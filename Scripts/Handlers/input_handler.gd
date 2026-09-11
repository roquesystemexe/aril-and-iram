extends Node
class_name InputHandler

func _restart() -> bool:
	if Input.is_action_just_pressed("restart"):
		GameManager.has_checkpoint = false;
		GameManager.dJump_enabled = false;
		GameManager.dash_enabled = false;
		return true;
	else:
		return false;

func _pause() -> bool:
	if Input.is_action_just_pressed("pause"):
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

func get_interact() -> bool:
	if Input.is_action_just_pressed("interact"):			# INTERACTION INPUT
		GameManager.is_interacting = true;
		#print(GameManager.is_interacting)
		return true;
	else:
		GameManager.is_interacting = false;
		return false;


func get_weapon_selection() -> int:
	if Input.is_action_just_pressed("number_1"):
		return 1;
	elif Input.is_action_just_pressed("number_2"):
		return 2;
	elif Input.is_action_just_pressed("number_3"):
		return 3;
	elif Input.is_action_just_pressed("number_4"):
		return 4;
	elif Input.is_action_just_pressed("number_5"):
		return 5;
	elif Input.is_action_just_pressed("number_6"):
		return 6;
	elif Input.is_action_just_pressed("number_7"):
		return 7;
	elif Input.is_action_just_pressed("number_8"):
		return 8;
	elif Input.is_action_just_pressed("number_9"):
		return 9;
	else:
		return 0;
