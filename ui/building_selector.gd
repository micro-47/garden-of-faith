extends Button

@export
var building_type: MainCharacter.Buildings = MainCharacter.Buildings.NONE
var building_name: String

var is_selected: bool = false

## this is shared for all since static
## accessed by the player
## when selected is -1, then none is selected. But if 0 then first slot, if 1 then the next, ...
#static var selected: int = -1

@onready
var player = get_node("/root/World/MainCharacter")

func _ready() -> void:
	match building_type:
		MainCharacter.Buildings.HOUSE:
			building_name = "House"
		MainCharacter.Buildings.FARM:
			building_name = "Farm"
		MainCharacter.Buildings.TEMPLE:
			building_name = "Temple"


func _draw() -> void:
	# Kinda wasteful, whatever
	var display_string = "Build "
	display_string += building_name
	if is_selected:
		display_string += "\n(Selected)"
	
	self.text = display_string


func _pressed() -> void:
	player.building_selector_clicked(get_parent().get_children().find(self))
