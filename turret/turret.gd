extends Node2D

# Distance from center of gun sprite to where projectile should spawn
@export var muzzle_distance: float = 75.0
@export_enum("Basic", "Homing") var turret_type: int = 0

@onready var target_component: TargetComponent = $TargetComponent
@onready var gun_sprite: Sprite2D = $GunSprite
@onready var fire_timer: Timer = $FireTimer
@onready var muzzle_marker: Marker2D = $MuzzleMarker2D
@onready var scale_component: ScaleComponent = $ScaleComponent

var projectile_scene = preload("res://projectile/projectile.tscn")
var homing_projectile_scene = preload("res://projectile/homing_projectile.tscn")

func _ready() -> void:
	target_component.target_creep_updated.connect(track_creep)
	fire_timer.timeout.connect(fire_projectile)

func _process(delta: float) -> void:
	track_creep()
	queue_redraw()

func track_creep() -> void:
	# Must have a creep to target
	if target_component.creep:
		var target_creep: Creep = target_component.creep as Creep

		rotate_gun(target_creep.global_position)
		
		if fire_timer.is_stopped():
			fire_projectile()
			fire_timer.start()
	else:
		fire_timer.stop()

func fire_projectile() -> void:
	spawn_projectile()
	scale_component.tween_scale()

func rotate_gun(target: Vector2) -> void:
	var angle = get_angle_to(target)
	# Rotate gun sprite to point to target
	gun_sprite.rotation = angle + deg_to_rad(90)
	# Move marker along circle with radius muzzle_distance
	var rotation = Vector2(cos(angle), sin(angle))
	muzzle_marker.position = rotation * muzzle_distance

func spawn_projectile() -> void:
	var scene: PackedScene
	match turret_type:
		0: scene = projectile_scene
		1: scene = homing_projectile_scene
		
	var projectile = scene.instantiate() as Projectile
	projectile.position = muzzle_marker.position
	# Fire projectile behind gun_sprite
	projectile.z_index = gun_sprite.z_index - 1
	if target_component.creep != null:
		projectile.target = target_component.creep
	
	add_child(projectile)
	
