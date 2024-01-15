class_name DrawVectorsComponent
extends Node2D

@export var move_component: MoveComponent

func _draw():
	draw_vectors()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	queue_redraw()

func draw_vectors() -> void:
	draw_line(Vector2.ZERO, move_component.move_stats.velocity * (move_component.move_stats.speed * .5), Color.DARK_GREEN, 5)
	draw_line(Vector2.ZERO, move_component.move_stats.acceleration * 7.5, Color.YELLOW, 5)
	
	if move_component is HomingMoveComponent:
		draw_line(Vector2.ZERO, move_component.move_stats.desired_velocity, Color.REBECCA_PURPLE, 5.0)
