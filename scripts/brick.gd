extends Node2D

var flag = false


func _on_area_entered(area: Area2D):
	if area.name == "BallArea" and flag == false:
		flag = true
		GlobalValue.score += 1
		# print(GlobalValue.score)
		if GlobalValue.total_bricks <= GlobalValue.score:
			$"../../GameController".update_level()
		queue_free()
