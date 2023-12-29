class_name MoveComponent
extends Node

@export var actor: Node2D
@export var velocity: Vector2
@export var speed = 30
@export var drag_factor = 1.1

var acceleration = Vector2.ZERO

func _physics_process(delta) -> void:
	var direction = Vector2.RIGHT.rotated(actor.rotation).normalized()
	if actor is Projectile:
		var projectile: Projectile = actor as Projectile
		if projectile.target != null:
			direction = projectile.global_position.direction_to(projectile.target.global_position)
		
		var desired_velocity = direction * speed
		var change = (desired_velocity - velocity) * drag_factor
		velocity += change
		
		projectile.position += velocity * delta
		projectile.look_at(projectile.global_position + velocity)
		
		#actor.look_at(actor.target.global_position)
		#actor.position = actor.position.move_toward(actor.target.global_position, speed * delta)
		return
	
	actor.position += speed * direction * delta
