extends Control


func _input(event):
	if event.is_action_pressed("pause"):
		var waht_pause_state = not get_tree().paused
		get_tree().paused = waht_pause_state
		visible=waht_pause_state
		print(waht_pause_state)
