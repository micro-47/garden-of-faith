extends CharacterBody2D


const SPEED = 1000.0

@onready var mainCam = $Camera

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	velocity = (direction * SPEED )/ mainCam.zoom 
	move_and_slide()
