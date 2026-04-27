extends Node2D

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	$HBoxContainer/PlayButton.button_pressed = false
	$HBoxContainer/QuitButton.button_pressed = false
	$MenuCam.enabled = false
	get_tree().change_scene_to_file("res://Scenes/Levels/TestLevel.tscn")
