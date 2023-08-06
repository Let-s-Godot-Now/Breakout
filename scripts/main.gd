extends Node2D

@onready var ball := $Ball


func _ready():
	ball.reset()
