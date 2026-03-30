extends Node2D

var input_handler := InputHandler.new();

func restart() -> void:
	get_tree().reload_current_scene();
func quit() -> void:
	get_tree().quit();
func _process(_delta: float) -> void:
	if input_handler._restart():
		restart();
	if input_handler._quit():
		quit();
