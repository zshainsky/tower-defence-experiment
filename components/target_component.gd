class_name TargetComponent
extends Node

@export var target_area: Area2D

var creep: Creep

signal target_creep_updated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.creep = null
	target_area.area_entered.connect(_creep_detected)
	target_area.area_exited.connect(_creep_exited)
	
func _process(delta) -> void:
	#_find_rand_creep()
	pass

func _creep_detected(area: Area2D) -> void:
	if area.get_parent() is Creep:
		var creep = area.get_parent() as Creep
		
		if self.creep == null or self.creep != creep:
			self.creep = creep
			target_creep_updated.emit()

func _creep_exited(area: Area2D) -> void:
	if area.get_parent() is Creep:
		var creep = area.get_parent() as Creep
		if self.creep == creep:
			self.creep = null
			target_creep_updated.emit()

func _find_first_creep() -> void:
	_find_creep(0)

func _find_rand_creep() -> void:
	var min = 0
	var max = len(target_area.get_overlapping_areas()) - 1
	_find_creep(randi_range(min, max))
	
func _find_creep(loc: int) -> void:
	if self.creep == null and target_area.has_overlapping_areas() and len(target_area.get_overlapping_areas()) >= loc:
		var new_area: Area2D = target_area.get_overlapping_areas()[loc] as Area2D
		if new_area.get_parent() is Creep:
			var creep: Creep = new_area.get_parent() as Creep
			self.creep = creep
			target_creep_updated.emit()
		
