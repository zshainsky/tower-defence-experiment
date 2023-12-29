class_name Projectile
extends Node2D

@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var move_stats: MoveStats = $MoveStats as MoveStats
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var lifetime_timer: Timer = $LifetimeTimer as Timer

var target: Node2D

func _ready():
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	lifetime_timer.timeout.connect(queue_free)
	
	move_component.velocity = move_component.speed * Vector2.RIGHT.rotated(rotation)
