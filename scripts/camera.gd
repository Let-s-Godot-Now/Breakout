## COPY FROM AV228909758
extends Camera2D

var _duaration: float = 0
var _period_in_ms: float = 0
var _amplitude: float = 0
var _timer: float = 0

var _previous_x: float = 0
var _previous_y: float = 0

var _last_shook_timer = 0
var _last_offset := Vector2(0, 0)


func _ready():
	set_process(true)
	GlobalValue.camera = self


func _process(delta):
	if _timer == 0:
		return
	_last_shook_timer = _last_shook_timer + delta
	while _last_shook_timer >= _period_in_ms:
		_last_shook_timer = _last_shook_timer - _period_in_ms
		var intensity = _amplitude * (1 - ((_duaration - _timer) / _duaration))
		var new_x = randf_range(-1.0, 1.0)
		var x_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
		var new_y = randf_range(-1.0, 1.0)
		var y_component = intensity * (_previous_x + (delta * (new_x - _previous_x)))
		_previous_x = new_x
		_previous_y = new_y
		var new_offset = Vector2(x_component, y_component)
		set_offset(get_offset() - _last_offset + new_offset)
		_last_offset = new_offset

	_timer = _timer - delta
	if _timer <= 0:
		_timer = 0
		set_offset(get_offset() - _last_offset)


func shake(duration, frequency, amplitude):
	if frequency == 0:
		return

	_duaration = duration
	_timer = duration
	_period_in_ms = 1.0 / frequency
	_amplitude = amplitude
	_previous_x = randf_range(-1.0, 1.0)
	_previous_y = randf_range(-1.0, 1.0)
	set_offset(get_offset() - _last_offset)
	_last_offset = Vector2(0, 0)
