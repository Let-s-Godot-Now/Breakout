extends Node2D

@onready var plane := $Plane
@onready var button_a: Button = $"../Controllers/ButtonA"
@onready var button_d = $"../Controllers/ButtonD"
@onready var button_shift := $"../Controllers/ButtonShift"
@onready var ghost_paddle := preload("res://tscn/ghost_paddle.tscn")

@export var speed := 500
var rem_speed_velocity: float = 0
var screen_size := Vector2.ZERO
var plane_size := Vector2.ZERO


func _ready():
	set_clamp()


func _process(delta):
	if Input.is_action_pressed("move_left") or button_a.button_pressed:
		if Input.is_action_pressed("faster_shift") or button_shift.button_pressed:
			position.x -= speed * delta * 2
			rem_speed_velocity = -speed * delta * 2
		else:
			position.x -= speed * delta
			rem_speed_velocity = -speed * delta
	elif Input.is_action_pressed("move_right") or button_d.button_pressed:
		if Input.is_action_pressed("faster_shift") or button_shift.button_pressed:
			position.x += speed * delta * 2
			rem_speed_velocity = speed * delta * 2
		else:
			position.x += speed * delta
			rem_speed_velocity = speed * delta
	else:
		rem_speed_velocity = 0
	position.x = clamp(position.x, plane_size.x / 2, screen_size.x - plane_size.x / 2)


func set_clamp() -> void:
	screen_size = get_viewport_rect().size
	plane_size = plane.get_rect().size
	plane_size.x *= scale.x


func reset() -> void:
	position.x = 576


func ghost_gen() -> void:
	if (
		Input.is_action_pressed("move_left")
		or Input.is_action_pressed("move_right")
		or button_a.button_pressed
		or button_d.button_pressed
	):
		if Input.is_action_pressed("faster_shift") or button_shift.button_pressed:
			var ghost_paddle_tscn = ghost_paddle.instantiate()
			ghost_paddle_tscn.position = position
			ghost_paddle_tscn.scale.x = scale.x
			ghost_paddle_tscn.get_node("Sprite2D").modulate.a = 0.7
			get_parent().add_child(ghost_paddle_tscn)
