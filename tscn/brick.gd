extends Node2D

var flag=false

func _on_up_area_entered(area:Area2D):
	if area.name == "BallArea":
		queue_free()
