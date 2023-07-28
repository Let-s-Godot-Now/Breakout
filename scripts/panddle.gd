extends Node2D

@onready var plane = get_node("Plane")

var speed = 1000
var screen_size = Vector2.ZERO
var plane_size = Vector2.ZERO


func _ready():
	screen_size = get_viewport_rect().size
	plane_size = plane.get_rect().size
	plane_size.x *= scale.x


func _process(delta):
	if Input.is_action_pressed("move_left"):
		position.x -= speed * delta
	elif Input.is_action_pressed("move_right"):
		position.x+=speed*delta
	position.x=clamp(position.x,plane_size.x/2,screen_size.x-plane_size.x/2)