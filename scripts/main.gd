extends Node2D

@onready var ball = get_node("Ball")

func _ready():
	ball.reset()

func _process(delta):
	pass
