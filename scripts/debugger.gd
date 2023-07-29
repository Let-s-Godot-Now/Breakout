extends Node

@export var is_debug_suitale:bool = false

func _ready():
	if is_debug_suitale:
		get_parent().get_node("Paddle").scale.x=1000
		get_parent().get_node("Ball").scale = Vector2(200,200)
		get_parent().get_node("Ball").speed = 2000
