extends Node2D

var input_handler := InputHandler.new();



func restart() -> void:
	get_tree().reload_current_scene();


func _unhandled_input(_event: InputEvent) -> void:
	if input_handler._restart():
		restart()
		
	if input_handler._pause() and !get_tree().paused:
		get_tree().paused = true
		$CanvasLayer/Options.visible = true
		get_viewport().set_input_as_handled()
