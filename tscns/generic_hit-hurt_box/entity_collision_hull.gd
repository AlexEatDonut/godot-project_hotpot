extends Area3D

@onready var timer = $Timer

@export var healthRatio = 0
@export var ammoRatio = 0

enum entityTypes {
	GENERIC = 0, 
	PICKUP = 1, 
	CONSUMABLE = 2, 
	WEAPON = 3}

@export var entityType  = 0

var respawningPickup = false : 
	set = respawn_pickup

signal pickup_RespawnStart
signal pickup_RespawnEnd

func _ready() -> void:
	match entityType:
		0:
			print("spawned entity : generic")
		1:
			print("spawned entity : pickup")
			print(str(healthRatio))
			print(str(ammoRatio))
		2:
			print("spawned entity : consumable")
		3:
			print("spawned entity : weapon")




#CODE RESPONSABLE FOR MAKING PICKUPS RESPAWN
#DOESNT APPLY TO CONSUMABLES (ONE TIME USE ITEMS) OR WEAPONS

func respawn_pickup(value):
	respawningPickup = value
	if respawningPickup == true :
		emit_signal("pickup_RespawnStart")
	else : 
		emit_signal("pickup_RespawnEnd")

func start_pickupRespawn(duration):
	self.respawningPickup = true
	emit_signal("pickup_RespawnStart")
	timer.start(duration)

func _on_timer_timeout():
	self.respawningPickup = false
	emit_signal("pickup_RespawnEnd")

func _on_pickup_respawn_start() -> void:
	set_deferred ("monitoring", false)

func _on_pickup_respawn_end() -> void:
	set_deferred ("monitoring", true)
