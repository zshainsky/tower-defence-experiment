extends Node2D

@onready var target_component: TargetComponent = $TargetComponent as TargetComponent
@onready var gun_sprite: Sprite2D = $GunSprite as Sprite2D
@onready var spawner_component: SpawnerComponent = $SpawnerComponent as SpawnerComponent
@onready var fire_timer: Timer = $FireTimer as Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner_component.global_position = gun_sprite.global_position
	target_component.target_creep_updated.connect(track_creep)
	fire_timer.timeout.connect(fire_projectile)
	
func _process(delta) -> void:
	track_creep()

func track_creep() -> void:
	# Must have a creep to target
	if target_component.creep:
		var creep: Creep = target_component.creep as Creep
		gun_sprite.rotate(angle_to_creep(creep, gun_sprite))
		spawner_component.rotate(angle_to_creep(creep, spawner_component))
		
		if fire_timer.is_stopped():
			fire_projectile()
			fire_timer.start()
	else:
		fire_timer.stop()

func fire_projectile() -> void:
	var spawn: Node2D = spawner_component.spawn_node2d(spawner_component.global_position) as Node2D
	if spawn is Projectile:
		var projectile: Projectile = spawn as Projectile
		projectile.target = target_component.creep

func angle_to_creep(creep: Creep, from_node: Node2D) -> float:
	var angle = 0
	if creep:
		angle = from_node.get_angle_to(creep.global_position) + deg_to_rad(90)
	return angle
