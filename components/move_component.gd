class_name MoveComponent
extends Node

@export var actor: Node2D
@export var move_stats: MoveStats

func _process(delta: float) -> void:
	update_actor_rotation()
	move(delta)
	
func move(delta: float) -> void:
	move_stats.velocity += move_stats.acceleration
	move_stats.velocity = move_stats.velocity.limit_length(move_stats.max_speed)
	actor.global_position += move_stats.velocity * move_stats.speed * delta 

func update_actor_rotation() -> void:
	var rotation: float = move_stats.velocity.angle()
	actor.global_rotation = rotation


