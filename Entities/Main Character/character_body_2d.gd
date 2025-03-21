extends CharacterBody2D

# used for imports
class_name MainCharacter

enum Buildings { NONE, FARM, TEMPLE }

# if index is -1, then nothing is selected
@export
var selected_building_index: int = -1
#var selected_building: Buildings = Buildings.NONE


const SPEED = 1000.0

@onready var mainCam = $Camera

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	velocity = (direction * SPEED )/ mainCam.zoom 
	move_and_slide()

func building_selector_clicked(index: int) -> void:
	if selected_building_index==index:
		# deselect
		selected_building_index = -1
	else:
		selected_building_index = index
	
	# Update the is_selected for all the building buttons
	# redundant but safer
	for i in range(%Hotbar.get_child_count()):
		%Hotbar.get_child(i).is_selected = i==selected_building_index
