extends Node2D

var input_handler := InputHandler.new();


func restart() -> void:
	get_tree().reload_current_scene();


func _unhandled_input(_event: InputEvent) -> void:
	if input_handler._restart():
		restart()

	if input_handler._pause() and !get_tree().paused:
		$CanvasLayer/Options.open_menu()
		get_viewport().set_input_as_handled()
		$CanvasLayer/Options/HBoxContainer/MainMenuButton.grab_focus()
