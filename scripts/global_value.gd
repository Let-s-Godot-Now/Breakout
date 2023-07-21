extends Node

# 游戏难度
enum Mode{
    EASY,
    NORMAL,
    DIFFICULT,
}
var global_mode: Mode = Mode.NORMAL