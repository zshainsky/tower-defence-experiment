class_name SpawnerComponent
extends Node2D

@export var scene: PackedScene

func spawn(global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner component.")
	var instance = scene.instantiate() as Node
	parent.add_child(instance)
	
	instance.global_position = global_spawn_position
	if instance is Node2D:
		var instance_node2d = instance as Node2D
		var angle = self.rotation
		instance_node2d.rotate(angle)
		instance = instance_node2d
			
	return instance
	
func spawn_node2d(global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node2D:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner component.")
	var instance = scene.instantiate() as Node2D
	
	assert(instance is Node2D, "Error: The instance for this spawner must extend Node2D")
	parent.add_child(instance)
	
	instance.global_position = global_spawn_position
	instance.rotate(self.rotation)
	return instance

func spawn_projectile(target: Node2D, global_spawn_position: Vector2 = global_position, parent: Node = get_tree().current_scene) -> Node2D:
	assert(scene is PackedScene, "Error: The scene export was never set on this spawner component.")
	var projectile = scene.instantiate() as Projectile
		
	projectile.position = global_spawn_position
	projectile.z_index = parent.z_index - 1
	if target != null:
		projectile.target = target
		
	assert(projectile is Projectile, "Error: The instance for this spawner must extend Node2D")
	add_child(projectile)

	return projectile
	
	
#func spawn_projectile() -> void:
	#var scene: PackedScene = load("res://projectile/projectile.tscn")
	#var projectile = scene.instantiate() as Projectile
	#projectile.position = muzzle_marker.position
	#projectile.z_index = self.z_index - 1
	#if target_component.creep != null:
		#projectile.target = target_component.creep
	#
	#add_child(projectile)
	#scale_component.tween_scale()
	
