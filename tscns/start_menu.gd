extends CanvasLayer

@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

func gameStarted():
	pass

func _on_btnsurfing_pressed() -> void:
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://tscns/level.tscn")


func _on_btnarena_pressed() -> void:
	SceneTransitionAnimation.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://tscns/level_openarena.tscn")


func _on_btnarenabasic_pressed() -> void:
		SceneTransitionAnimation.play("fadeIn")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://tscns/level_standardArena.tscn")
