extends Node

@onready var animation_player: AnimationPlayer = $CanvasLayer/AnimationPlayer

func _ready():
	animation_player.play("ui_into")

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://tscn/main.tscn")
