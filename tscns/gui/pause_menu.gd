extends Control

var _is_paused:bool = false:
	set = set_paused

func _ready() -> void:
	Playerinfo.connect("no_health", queue_free)

func _unhandled_input(event) -> void:
	if event.is_action_pressed("esc"):
		_is_paused = !_is_paused
		emit_signal("isPaused", _is_paused)
		if _is_paused == true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif _is_paused == false:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	
func _on_btnresume_pressed() -> void:
	_is_paused = false
	emit_signal("isPaused", _is_paused)

func _on_btnrestart_pressed() -> void:
	_is_paused = false
	emit_signal("isPaused", _is_paused)
	Playerinfo.health = Playerinfo.max_health
	get_tree().reload_current_scene()

func _on_btnsettings_pressed() -> void:
	pass # Replace with function body.

func _on_btnquit_pressed() -> void:
	get_tree().quit()

signal isPaused(bool)
