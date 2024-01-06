class_name MoveComponent
extends Node

@export var actor: Node2D
@export var move_stats: MoveStats

func _process(delta: float) -> void:
	update_sprite_direction()
	move(delta)
	
func move(delta: float) -> void:
	move_stats.velocity += move_stats.acceleration
	move_stats.velocity = move_stats.velocity.limit_length(move_stats.max_speed)
	actor.global_position += move_stats.velocity * move_stats.speed * delta 

func update_sprite_direction() -> void:
	if actor is Projectile:
		var projectile: Projectile = actor
		var rotation: float = move_stats.velocity.angle() + deg_to_rad(90)
		projectile.sprite_2d.global_rotation = rotation
		projectile.collision_shape_2d.global_rotation = rotation


