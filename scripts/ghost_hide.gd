extends Node


func _on_timer_timeout():
	if $Sprite2D.modulate.a > 0:
		$Sprite2D.modulate.a -= 0.1
	else:
		$Sprite2D.modulate.a = 0
		queue_free()
