class_name WeaponResource
extends Resource


@export_category("Weapon data")
@export var name : StringName
@export var damage : float
@export var weapon_type : StringName
@export var sound : PackedScene
@export var fire_interval : float
@export var reload_spd : float

@export_category("Weapon Positionning")
@export var position : Vector3
@export var rotation : Vector3

@export_category("Visual settings")
@export var mesh : Mesh
