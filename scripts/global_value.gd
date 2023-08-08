extends Node

# 游戏难度
enum Mode {
	EASY,
	NORMAL,
	DIFFICULT,
}
var global_mode: Mode = Mode.NORMAL

var score := 0

var total_bricks := 0

var start_game := true

var leyline_lock = false

#### NODES ####

var camera: Camera2D

var bricks: Node2D

var paddle: Node2D

var walls: Node2D

var ball: Node2D
