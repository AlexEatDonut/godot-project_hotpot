extends Control

func _ready() -> void:
	Playerinfo.connect("no_health", _on_death)
func _on_death() -> void:
	Playerinfo.playerIsDead = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	visible = true
	await get_tree().create_timer(0.8).timeout
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_btnretry_pressed() -> void:
	get_tree().paused = false
	Playerinfo.playerIsDead = false
	Playerinfo.health = Playerinfo.max_health
	get_tree().reload_current_scene()

func _on_btnquit_pressed() -> void:
	get_tree().quit()
