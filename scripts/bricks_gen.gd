extends Node2D

@export var start_point := 140
@export var brick_weight := 100
@export var brick_horiz_num := 8


func _ready():
	var screen_size := get_viewport_rect().size

	# var end_point = screen_size.x - start_point
	var brick_interval := (screen_size.x - brick_weight * brick_horiz_num) / (brick_horiz_num - 1)
	if brick_interval < 0:
		brick_interval = 0

	print(brick_interval)

	
