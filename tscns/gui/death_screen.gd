extends Control

func _ready() -> void:
	Playerinfo.connect("no_health", _on_death)
	pass
func _on_death() -> void:
	get_tree().paused = true
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_btnretry_pressed() -> void:
	get_tree().reload_current_scene()

func _on_btnquit_pressed() -> void:
	get_tree().quit()
