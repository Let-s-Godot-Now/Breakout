extends Node2D

@onready var plane = $Plane
@onready var paddle = preload("res://tscn/ghost_paddle.tscn")

@export var speed = 500
var rem_speed_velocity: float
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
			rem_speed_velocity = -speed * delta * 2
		else:
			position.x -= speed * delta
			rem_speed_velocity = -speed * delta
	elif Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("faster_shift"):
			position.x += speed * delta * 2
			rem_speed_velocity = speed * delta * 2
		else:
			position.x += speed * delta
			rem_speed_velocity = speed * delta
	else:
		rem_speed_velocity = 0
	position.x = clamp(position.x, plane_size.x / 2, screen_size.x - plane_size.x / 2)

func ghost_gen():
	if Input.is_action_pressed("faster_shift"):
		var paddle_tscn = paddle.instantiate()
		paddle_tscn.position = position
		paddle_tscn.get_node("Sprite2D").modulate.a = 0.7
		get_parent().add_child(paddle_tscn)
		print(1)
