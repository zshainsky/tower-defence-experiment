class_name Creep
extends Node2D

@onready var visible_on_screen_notifier_2d = $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D
@onready var stats_component: StatsComponent = $StatsComponent as StatsComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	stats_component.no_health.connect(queue_free)
