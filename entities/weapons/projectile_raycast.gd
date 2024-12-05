extends RayCast3D

@export var SPEED := 50
@export var damage = 5
@export var player_affiliation : bool
@export var lingering : bool

@onready var remote_transform := RemoteTransform3D.new()
@onready var mesh = $MeshInstance3D
@onready var bullet_decal = preload("res://entities/decals/bullet_decal.tscn")

var target

#code imported from raycast hitbox
signal collide_world()
signal collide_body(collider)

func _ready() -> void:
	self.top_level = true

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * SPEED * delta
	target_position = Vector3.FORWARD * SPEED * delta
	force_raycast_update()
	target = get_collider()
	if is_colliding():
		#var bullet_hole = bullet_decal.instantiate()
		var pt = get_collision_point()
		var nrml = get_collision_normal()
		global_position = get_collision_point()
		#create_bullethole(bullet_hole, target)
		BulletDecalPool.spawn_bullet_decal(pt, nrml, target )
		set_physics_process(false)
		print(target.get_collision_layer())
		#CODE THAT NEEDS REWRITE : DETECT WHICH LAYER IT IS DETECTING WITH
		#if target.get_collision_layer() == 401:
		#pass
		#else : 
			#emit_signal("collide_body", target)
		#print(target)
		emit_signal("collide_body", target)
		if lingering == true :
			target.add_child(remote_transform)
			remote_transform.global_transform = global_transform
			remote_transform.remote_path = remote_transform.get_path_to(self)
			remote_transform.tree_exited.connect(_cleanup)
		else :
			_cleanup()

func create_bullethole(bh, target):
	var root = get_tree().current_scene
	root.add_child(bh)
	bh.global_transform.origin = get_collision_point()
	#if get_collision_normal() == Vector3(1,0,0):
		#bh.look_at(get_collision_point() + get_collision_normal(), Vector3.RIGHT)
	#elif get_collision_normal() == Vector3(-1,0,0):
		#bh.look_at(get_collision_point() + get_collision_normal(), Vector3.RIGHT)
	#else:
		#bh.look_at(get_collision_point() + get_collision_normal())

func _cleanup() -> void:
	queue_free()


func _on_collide_body(collider: Variant) -> void:
	#this is a hacky way to get around the hitbox system i have put in place. 
	#I should call upon signals or some other ways later 
	var target = collider.get_parent_node_3d() 
	if target.is_in_group("Enemy") && player_affiliation == true :
		target._decrease_health(damage)
	if target.is_in_group("Player") && player_affiliation == false :
		pass
