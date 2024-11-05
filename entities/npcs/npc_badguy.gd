extends CharacterBody3D

@onready var stats = $EnemyStats
@onready var hitbox = $Hitbox

@onready var health = stats.health
#var health = 100

func _ready():
	pass

#func _process(delta):
	#if health <= 0:
		#queue_free()

func _on_taking_damage(value):
	#stats.health -= value
	health -= value
	hitbox.start_graceperiod(1)
	print("processed starting graceperiod of 1 sec")


func _on_hitbox_graceperiod_started() -> void:
	pass # put some animations on this guy

func _on_hitbox_graceperiod_ended() -> void:
	pass # stop some animations on this guy


func _on_enemy_stats_no_health() -> void:
	#create_death_effect() 
	#aka create effects on death lmao
	print("queue-ing free-ing the bad guy >:)")
	queue_free()


func _on_enemy_stats_health_changed(value: Variant) -> void:
	# this is a bad way of doing this
	#health = stats.health
	pass
