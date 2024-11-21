extends RayCast3D

@export var playerHitscan : bool = true
@export var damage : float

var hasTriggered:bool = false

signal collide_world()
signal collide_body(collider)

func _ready() -> void:
	self.top_level = true
	#print("instantiated a raycast")
	if is_colliding():
		pass
	await get_tree().create_timer(0.1).timeout
	hasTriggered = true
	await get_tree().create_timer(3).timeout
	queue_free()

func _physics_process(delta: float) -> void:
	if hasTriggered != true:
		if is_colliding():
			var target = get_collider()
			hasTriggered = true
			print(target.get_collision_layer())
			#CODE THAT NEEDS REWRITE : DETECT WHICH LAYER IT IS DETECTING WITH
			#if target.get_collision_layer() == 401:
				#pass
			#else : 
				#emit_signal("collide_body", target)
			#print(target)
			emit_signal("collide_body", target)
			

func _on_collide_body(collider: Variant) -> void:
	#this is a hacky way to get around the hitbox system i have put in place. 
	#I should call upon signals or some other ways later 
	var target = collider.get_parent_node_3d() 
	if target.is_in_group("Enemy"):
		target._decrease_health(damage)
