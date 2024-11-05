extends Area3D

#const HitEffect = preload("res://Effects/hit_effect.tscn")

#remnant code of the 2D action rpg where it would deal damage i believe ?
#@export var damage = 1

@onready var timer = $Timer

var gracePeriod = false : 
	set = set_graceperiod

signal graceperiod_started
signal graceperiod_ended

func set_graceperiod(value):
	gracePeriod = value
	if gracePeriod == true :
		emit_signal("graceperiod_started")
	else : 
		emit_signal("graceperiod_ended")

func start_graceperiod(duration):
	self.gracePeriod = true
	emit_signal("graceperiod_started")
	timer.start(duration)

#this code was made when it was for a 2D game
#func create_hit_effect():
	#var effect  = HitEffect	.instantiate()
	#var main = get_tree().current_scene
	#main.add_child(effect)
	#effect.global_position = global_position

func _on_timer_timeout():
	self.gracePeriod = false
	emit_signal("graceperiod_ended")

func _on_graceperiod_started() -> void:
	set_deferred ("monitoring", false)

func _on_graceperiod_ended() -> void:
	set_deferred ("monitoring", true)
