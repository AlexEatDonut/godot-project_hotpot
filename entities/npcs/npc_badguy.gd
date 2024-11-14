#extends StateMachine
extends CharacterBody3D

@onready var stats = $EnemyStats
@onready var hitbox = $Hitbox

@onready var raycast = $RayCast3D
@onready var eyes = $Eyes

@onready var shoottimer = $ShootTimer

var target

const TURN_SPEED = 2

enum {
	IDLE,
	ALERT
}

var state = IDLE

func _ready():
	pass

func _process(delta):
	match state:
		IDLE:
			pass
		ALERT:
			eyes.look_at(target.global_transform.origin, Vector3.UP)
			rotate_y(deg_to_rad(eyes.rotation.y * TURN_SPEED))

func _on_sight_range_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		target = body
		state = ALERT
		shoottimer.start()

func _on_sight_range_body_exited(body: Node3D) -> void:
	state = IDLE
	shoottimer.stop()

func _on_shoot_timer_timeout() -> void:
	if raycast.is_colliding():
		var hit = raycast.get_collider()
		if hit.is_in_group("Player"):
			print("Hit!")



#HEALTH RELATED CODE

func _decrease_health(value):
	stats.health -= value
	#the game attempts to start a grace period but fails due to the raycast still being in his hitbox, 
	#preventing any changes to the monitoring to happen
		#TODO : Find a way to accomplish this idea
		#hitbox.start_graceperiod(1)
		#print("processed starting graceperiod of 1 sec")

func _on_hitbox_graceperiod_started() -> void:
	pass # put some animations on this guy

func _on_hitbox_graceperiod_ended() -> void:
	pass # stop some animations on this guy


func _on_enemy_stats_no_health() -> void:
	#create_death_effect() 
	#aka create effects on death lmao
	print("enemy lost all health , queue free-ing")
	queue_free()


func _on_enemy_stats_health_changed(value: Variant) -> void:
	# check if health got bigger or lower, then do things accordingly with other signals
	pass
