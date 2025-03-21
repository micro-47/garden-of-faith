extends Node2D


class_name Building

var workers: int = 0


@export
var BUILDING_TYPE: MainCharacter.Buildings = MainCharacter.Buildings.FARM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO: is allowed to do this every n frames
	for villager in $Area2D.get_overlapping_bodies():
		if villager is Villager:
			villager.building_entered(self)


func is_building_full() -> bool:
	# current capacity: 1
	return workers >= 1
