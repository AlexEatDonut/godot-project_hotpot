extends Node3D

@export var fireInterval  = 0.2
#@onready var shotsPerSecond = 
#calculus is hard

enum{
	IDLE,
	SHOOTING,
	RELOADING
}

var state = IDLE 

#Variable to test damaging enemies
@onready var aimcast = $DevDamageBeam
@onready var timer = $Timer

var _duration_fired = 0

func _ready() -> void:
	pass

func playGunShot():
	var gunShot = preload("res://sounds/weapons/gun_test.tscn").instantiate()
	get_tree().current_scene.add_child(gunShot)


func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("click"):
		state = SHOOTING
		_weapon_fire()
	if event.is_action_released("click"):
		state = IDLE
		


func _weapon_fire():
	while state == SHOOTING :
		print("shooting with my weapon :)")
		playGunShot()
		await get_tree().create_timer(fireInterval).timeout
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			#this is a hacky way to get around the hitbox system i have put in place. 
			#I will call upon signals or some other ways later 
			var target_charBody = target.get_parent_node_3d()
			#print(str(target_charBody.stats.health))
			if target_charBody.is_in_group("enemy"):
				target_charBody._on_taking_damage(10)
				print("hit enemy")
				
				#target_charBody.health -= 10
