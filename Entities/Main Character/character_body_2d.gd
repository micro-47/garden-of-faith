extends CharacterBody2D


const SPEED = 1000.0

@onready var mainCam = $Camera
@onready var generator = get_node("/root/TestWorld/NoiseGenerator")

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("camera_left","camera_right","camera_up","camera_down")
	velocity = (direction * SPEED )/ mainCam.zoom 
	move_and_slide()

func _input (ev):
	if Input.is_key_pressed(KEY_K):
		print(generator)
		generator.generate_chunk(Vector2(17,2))
		print("works")
