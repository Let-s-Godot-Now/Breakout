extends Node2D

@onready var colli_shape = get_node("BallArea/CollisionShape2D")

var speed = 600
var velocity = Vector2.ZERO


func _process(delta):
	if GlobalValue.start_game == true:
		position += velocity * delta
		rotation_degrees += 10


func reset():
	position = get_viewport_rect().size / 2
	velocity = Vector2.DOWN * speed


func _on_ball_area_entered(area: Area2D):
	match area.name:
		"Up":
			bounce(-PI / 2)
		"Down":
			bounce(PI / 2)
		"Left":
			bounce(PI)
		"Right":
			bounce(0)
		"leyline of the void":
			reset()


func bounce(dir):
	randomize()
	dir += randf_range(-PI / 3, PI / 3)
	rotation = dir
	velocity = Vector2(1, 0).rotated(dir) * speed
