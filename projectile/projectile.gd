class_name Projectile
extends Node2D

@onready var move_component: MoveComponent = $MoveComponent as MoveComponent
@onready var move_stats: MoveStats = $MoveStats as MoveStats
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D
@onready var hitbox_component: HitboxComponent = $HitboxComponent as HitboxComponent
@onready var lifetime_timer: Timer = $LifetimeTimer as Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $HitboxComponent/CollisionShape2D

@onready var target: Node2D

func _ready():
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
	lifetime_timer.timeout.connect(queue_free)
	
	move_stats.velocity = (target.global_position - self.global_position).normalized() * move_stats.speed
