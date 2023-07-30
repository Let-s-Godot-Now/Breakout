extends Node

@onready var ball = $"../../Ball"
@onready var paddle = $"../../Paddle"
@onready var bricks = $"../../Bricks"

@export var is_debug_suitale: bool = false


func _ready():
	if is_debug_suitale:
		paddle.scale.x = 1000
		ball.scale = Vector2(200, 200)
		ball.speed = 2000
