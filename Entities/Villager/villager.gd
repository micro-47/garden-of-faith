extends CharacterBody2D


# finite state machine (https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/)
enum VillagerActionStates {WALK, IDLE, EAT}
@export
var state: VillagerActionStates = VillagerActionStates.IDLE


const SPEED: float = 300.0


# only makes sense in the WALK state
@export
var destination: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	match state:
		VillagerActionStates.WALK:
			var direction := position.direction_to(destination)
			velocity = direction * SPEED

			move_and_slide()
