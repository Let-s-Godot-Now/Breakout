extends Control


func _input(event):
	if event.is_action_pressed("pause"):
		var waht_pause_state = not get_tree().paused
		get_tree().paused = waht_pause_state
		visible = waht_pause_state
		print(waht_pause_state)


func _on_back_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://tscn/main_menu.tscn")
