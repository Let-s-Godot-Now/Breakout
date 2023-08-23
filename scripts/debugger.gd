extends Node

@export var is_debug_suitale: bool = false


func _ready():
	if is_debug_suitale:
		GlobalValue.paddle.scale.x = 1000
		GlobalValue.ball.scale = Vector2(200, 200)
		GlobalValue.ball.speed = 2000
