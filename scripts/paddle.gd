extends Node2D

@onready var plane = $Plane

var speed = 500
var screen_size = Vector2.ZERO
var plane_size = Vector2.ZERO


func _ready():
	set_clamp()

func set_clamp():
	screen_size = get_viewport_rect().size
	plane_size = plane.get_rect().size
	plane_size.x *= scale.x


func reset():
	position.x = 576


func _process(delta):
	# Paddle L&R movement
	if Input.is_action_pressed("move_left"):
		if Input.is_action_pressed("faster_shift"):
			position.x -= speed * delta * 2
		else:
			position.x -= speed * delta
	elif Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("faster_shift"):
			position.x += speed * delta * 2
		else:
			position.x += speed * delta
	position.x = clamp(position.x, plane_size.x / 2, screen_size.x - plane_size.x / 2)
