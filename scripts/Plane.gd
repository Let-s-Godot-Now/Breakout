extends CharacterBody2D

var speed := 300


func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
		direction += 1
	if Input.is_action_pressed("faster_shift"):
		direction *= 2

	var this_velocity = Vector2()
	this_velocity.x = speed * direction
	move_and_collide(this_velocity * delta)
