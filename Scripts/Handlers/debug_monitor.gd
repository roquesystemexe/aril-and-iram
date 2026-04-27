extends CanvasLayer

@onready var label = $VBoxContainer/Label

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_debug"):
		visible = !visible
		get_viewport().set_input_as_handled()

func _process(_delta: float) -> void:
	# Only run if label exists to prevent the 'null instance' crash
	if label:
		label.text = (
			"--- GameManager Stats ---\n" +
			"Respawn: " + str(GameManager.respawn_point) + "\n" +
			"Has Checkpoint: " + str(GameManager.has_checkpoint) + "\n" +
			"Double Jump: " + str(GameManager.dJump_enabled) + "\n" +
			"Dash: " + str(GameManager.dash_enabled) + "\n" +
			"CP Double Jump: " + str(GameManager.checkpoint_djump) + "\n" +
			"CP Dash: " + str(GameManager.checkpoint_dash) + "\n" +
			"Is Interacting: " + str(GameManager.is_interacting)
		)
		
