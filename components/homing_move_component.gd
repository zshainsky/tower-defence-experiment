class_name HomingMoveComponent
extends MoveComponent

@export var max_force: float = .75

# Setting as class variable to make visualization easier
@onready var desired_velocity: Vector2 = get_desired_velocity()

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO(zshainsky): remove this - temporarily enforce a slow speed here to start
	move_stats.speed = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_sprite_direction()
	seek_target()
	move(delta)

func seek_target() -> void:
	# Target must exist to seek target
	if actor.target != null:
		desired_velocity = get_desired_velocity()
		var steer = (desired_velocity - move_stats.velocity).limit_length(move_stats.max_force)
		move_stats.acceleration += steer
	
func get_desired_velocity() -> Vector2:
	return (actor.target.global_position - actor.global_position).normalized() * move_stats.max_speed
