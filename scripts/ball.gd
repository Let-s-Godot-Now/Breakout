extends Node2D

@onready var colli_shape: CollisionShape2D = $BallArea/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var brick_arr: Node2D = GlobalValue.bricks
@onready var paddle: Node2D = GlobalValue.paddle
@onready var walls: Node2D = GlobalValue.walls

var knock_sound1 = preload("res://res/audio/ball_knock_1.ogg")
var knock_sound2 = preload("res://res/audio/ball_knock_2.ogg")

@export var speed := 600
var velocity := Vector2.ZERO


func _process(delta):
	if GlobalValue.start_game == true:
		position += velocity * delta
		# rotation_degrees += 10


func reset() -> void:
	position = get_viewport_rect().size / 2
	velocity = Vector2.DOWN * speed


func back2center() -> void:
	if GlobalValue.leyline_lock == false:
		GlobalValue.leyline_lock = true
		velocity = Vector2.ZERO
		GlobalValue.camera.shake(0.8, 30, 15)
		rotation = 0

		await get_tree().create_timer(1.0).timeout
		position.y = get_viewport_rect().size.y
		bounce(
			position.angle_to_point(
				Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
			),
			9
		)
		GlobalValue.camera.shake(0.8, 30, 15)
		GlobalValue.leyline_lock = false


func _on_ball_area_entered(area: Area2D) -> void:
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
		# "leyline of the void":
		# 	reset()
		# 	$"../Paddle".reset()
		# 	# if not GlobalValue.leyline_lock:
		# 	# 	GlobalValue.leyline_lock = true
		# 	# 	GlobalValue.camera.shake(0.8, 30, 15)

		# 	# 	await get_tree().create_timer(3.0).timeout
		# 	# 	position.y = get_viewport_rect().size.y
		# 	# 	velocity = Vector2.ZERO
		# 	# 	rotation = 0
		# 	# 	bounce(-PI / 2, 9)
		# 	# 	GlobalValue.camera.shake(0.8, 30, 15)
		# 	# 	GlobalValue.leyline_lock = false
	if area.get_parent().get_parent() == brick_arr:
		var particles = load("res://tscn/boom_particles.tscn").instantiate()
		area.get_parent().get_parent().add_child(particles)
		particles.position = area.get_parent().position
		particles.get_node("Particles").emitting = true

		GlobalValue.camera.shake(0.3, 30, 15)
	elif area.get_parent().get_parent() == walls:
		GlobalValue.camera.shake(0.3, 30, 10)
	elif area.get_parent() == paddle:
		GlobalValue.camera.shake(0.2, 20, 5)

	var sound
	if randf() > 0.5:
		sound = knock_sound1
	else:
		sound = knock_sound2

	$AudioStreamPlayer2D.stream = sound
	$AudioStreamPlayer2D.play()


func bounce(dir, degree) -> void:
	randomize()
	dir += randf_range(-PI / degree, PI / degree)
	rotation = dir
	velocity = Vector2(1, 0).rotated(dir) * speed
	animation_player.play("ball_bounce")
