extends Node3D

@export var fireInterval  = 0.2
#@onready var shotsPerSecond = 
#calculus is hard
@export var weaponDamage = 10

enum{
	IDLE,
	SHOOTING,
	RELOADING
}

var state = IDLE 

#Variable to test damaging enemies
@onready var timer = $Timer
#preloading the raycast to call upon it later
var hitscan = preload("res://tscns/generic_hit-hurt_box/raycast3d_hitscan.tscn")

var readyForFire = true

var deltaTime:float

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	deltaTime = delta

func playGunShot():
	var gunShot = preload("res://sounds/weapons/gun_test.tscn").instantiate()
	get_tree().current_scene.add_child(gunShot)


func _unhandled_input(event : InputEvent):
	if event.is_action_pressed("click"):
		state = SHOOTING
		_weapon_fire(deltaTime)
	if event.is_action_released("click"):
		state = IDLE



func _weapon_fire(delta):
	while state == SHOOTING :
		#print(timer.time_left)
		if timer.time_left == 0 :
		#print("shooting with my weapon :)")
			playGunShot()
			var damageHitscan = hitscan.instantiate()
			damageHitscan.transform.origin = $hitscanOrigin.transform.origin
			add_child(damageHitscan)
			timer.start(fireInterval)
			readyForFire = false
		await get_tree().create_timer(delta).timeout


func _on_timer_timeout() -> void:
	readyForFire = true
	timer.stop()
