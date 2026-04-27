extends Control
var input_handler := InputHandler.new();


func toggle_menu() -> void:
	var is_paused = get_tree().paused
	get_tree().paused = !is_paused
	visible = !is_paused

func _on_music_toggle_toggled(toggled_on: bool) -> void:
	# Get the index of the "Music" bus
	var bus_index = AudioServer.get_bus_index("Music")
	
	# Use AudioServer to set the mute state
	# If toggled_on is true (checked), we want NOT muted (false)
	AudioServer.set_bus_mute(bus_index, !toggled_on)

func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _unhandled_input(_event: InputEvent) -> void:
	# Use the same input detection as your handler
	if input_handler._pause() and visible:
		toggle_menu()
		get_viewport().set_input_as_handled()
