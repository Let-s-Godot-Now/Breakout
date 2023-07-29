extends Node

# 游戏难度
enum Mode {
	EASY,
	NORMAL,
	DIFFICULT,
}
var global_mode: Mode = Mode.NORMAL

var score = 0

var start_game = true

var total_bricks