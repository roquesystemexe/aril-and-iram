extends Control
var input_handler := InputHandler.new();
var bus_index = AudioServer.get_bus_index("Music")

func _ready() -> void:
	$HBoxVolume/HSlider.value = GameManager.music_volume
	#print(GameManager.music_volume)

func _process(_delta: float) -> void:
	$HBoxMusicToggle/MusicToggle.button_pressed = GameManager.music_toggled

func _is_in_level() -> bool:
	var current_scene := get_tree().current_scene
	return current_scene != null and current_scene.is_in_group("Level")

func open_menu() -> void:
	var current_scene := get_tree().current_scene

	if _is_in_level():
		get_tree().paused = true

	$HBoxContainer/GoBackButton.visible = _is_in_level()
	visible = true

func close_menu() -> void:
	get_tree().paused = false
	visible = false

func toggle_menu() -> void:
	if visible:
		close_menu()
	else:
		open_menu()

func _on_music_toggle_toggled(toggled_on: bool) -> void:
	# Use AudioServer to set the mute state
	# If toggled_on is true (checked), we want NOT muted (false)
	AudioServer.set_bus_mute(bus_index, !toggled_on)
	GameManager.music_toggled = toggled_on

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Menus/main_menu.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _unhandled_input(_event: InputEvent) -> void:
	if input_handler._pause() and visible and _is_in_level():
		toggle_menu()
		get_viewport().set_input_as_handled()



func _on_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(bus_index, value/100)
	$HBoxVolume/HSlider.value = value
	GameManager.music_volume = value


func _on_go_back_button_pressed() -> void:
	toggle_menu()

func show_button(button: Button) -> void:
	button.set_visible(true)

func hide_button(button: Button) -> void:
	button.set_visible(false)
