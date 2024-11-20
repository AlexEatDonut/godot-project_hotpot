extends CanvasLayer

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func gameStarted():
	pass

func button_click_sfx():
	var btn_onclick_sfx = preload("res://sounds/ui/button_onclick.tscn").instantiate()
	get_tree().current_scene.add_child(btn_onclick_sfx)

func _on_btnsurfing_pressed() -> void:
	button_click_sfx()
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://tscns/level.tscn")


func _on_btnarena_pressed() -> void:
	button_click_sfx()
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://tscns/level_openarena.tscn")


func _on_btnarenabasic_pressed() -> void:
	button_click_sfx()
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://tscns/level_standardArena.tscn")
