extends Node2D

var flag = false


func _on_area_entered(area: Area2D):
	if area.name == "BallArea" and flag == false:
		flag = true
		GlobalValue.score += 1
		print(GlobalValue.score)
		if GlobalValue.total_bricks <= GlobalValue.score:
			print("win")
			GlobalValue.score = 0
			$"../../Ball".reset()
			$"../../Paddle".reset()
			get_parent().brick_vert_gen_num += 1
			get_parent().brick_horiz_gen_num += 1
			get_parent().gen_bricks()
		queue_free()
