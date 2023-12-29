class_name HurtComponent
extends Node

@export var stats_component: StatsComponent
@export var hurtbox_compoennt: HurtboxComponent


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurtbox_compoennt.hurt.connect(apply_hurt)

func apply_hurt(hitbox_component: HitboxComponent) -> void:
	stats_component.health -= hitbox_component.damage
