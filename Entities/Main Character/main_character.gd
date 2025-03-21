extends Node2D

# used for imports
class_name MainCharacter

enum Buildings { NONE, FARM, TEMPLE }

# if index is -1, then nothing is selected
@export
var selected_building_index: int = -1
var selected_building: Buildings = Buildings.NONE


@export
var faith: int = 10


func building_selector_clicked(index: int) -> void:
	if selected_building_index==index:
		# deselect
		selected_building_index = -1
	else:
		selected_building_index = index
	
	# Update the is_selected for all the building buttons
	# redundant but safer
	for i in range(%Hotbar.get_child_count()):
		%Hotbar.get_child(i).is_selected = (i==selected_building_index)
		
	update_selected_building()

func update_selected_building():
	if selected_building_index==-1:
		selected_building = Buildings.NONE
	else:
		selected_building = %Hotbar.get_child(selected_building_index).building_type

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		# place building
		match selected_building:
			# TODO: abstract this
			Buildings.FARM:
				if faith-3 < 0:
					print("Not enough faith for farm ("+str(faith)+"/"+str(3)+").")
				else:
					var farm_scene = preload("res://buildings/farm.tscn")
					var farm_instance = farm_scene.instantiate()
					farm_instance.global_position = get_global_mouse_position()
					get_node("/root/World").add_child(farm_instance)
					
					faith -= 3
			Buildings.TEMPLE:
				if faith-5 < 0:
					print("Not enough faith for temple ("+str(faith)+"/"+str(5)+").")
				else:
					var temple_scene = preload("res://buildings/temple.tscn")
					var temple_instance = temple_scene.instantiate()
					temple_instance.global_position = get_global_mouse_position()
					get_node("/root/World").add_child(temple_instance)
					
					faith -= 5

#func _draw() -> void: # this wasn't being called
func _process(delta: float) -> void:
	%FaithLabel.text = "Faith: " + str(faith)
