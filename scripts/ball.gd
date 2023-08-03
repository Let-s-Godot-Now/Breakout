extends Node2D

@onready var colli_shape = $BallArea/CollisionShape2D
@onready var brick_arr = $"../Bricks"
@onready var paddle = $"../Paddle"
@onready var animation_player = $AnimationPlayer


var knock_sound1 = preload("res://res/audio/ball_knock_1.ogg")
var knock_sound2 = preload("res://res/audio/ball_knock_2.ogg")

@export var speed = 600
var velocity = Vector2.ZERO


func _process(delta):
	if GlobalValue.start_game == true:
		position += velocity * delta
		# rotation_degrees += 10


func reset():
	position = get_viewport_rect().size / 2
	velocity = Vector2.DOWN * speed


func _on_ball_area_entered(area: Area2D):
	match area.name:
		"PaddleNoodle":
			if paddle.rem_speed_velocity == 0:
				bounce(-PI / 2, 5)
			else:
				bounce(-PI / 2 + paddle.rem_speed_velocity / 4, 9)
		"Up":
			bounce(-PI / 2, 3)
		"Down":
			bounce(PI / 2, 3)
		"Left":
			bounce(PI, 3)
		"Right":
			bounce(0, 3)
		"leyline of the void":
			reset()
			$"../Paddle".reset()
	if area.get_parent().get_parent() == brick_arr:
		var particles = load("res://tscn/boom_particles.tscn").instantiate()
		area.get_parent().get_parent().add_child(particles)
		particles.position = area.get_parent().position
		particles.get_node("Particles").emitting = true

	var sound
	if randf() > 0.5:
		sound = knock_sound1
	else:
		sound = knock_sound2
	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()


func bounce(dir, degree):
	randomize()
	dir += randf_range(-PI / degree, PI / degree)
	rotation = dir
	velocity = Vector2(1, 0).rotated(dir) * speed
	animation_player.play("ball_bounce")

