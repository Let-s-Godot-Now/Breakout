extends Node2D

@onready var ball = get_node("Ball")

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.reset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
