extends CharacterBody2D


@export
var food: float = 100.


# finite state machine (https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/)
enum VillagerActionStates {WALK, IDLE, EAT}
@export
var state: VillagerActionStates = VillagerActionStates.IDLE

const WALK_HUNGER: float = 1.
const IDLE_HUNGER: float = 0.25


const SPEED: float = 300.0


# only makes sense in the WALK state
@export
var destination: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	match state:
		VillagerActionStates.WALK:
			if position.distance_squared_to(destination) < 0.01:
				state = VillagerActionStates.IDLE
				position = destination
				return
			
			var direction := position.direction_to(destination)
			velocity = direction * SPEED

			move_and_slide()
			
			# walking costs food
			food -= delta * WALK_HUNGER
		VillagerActionStates.IDLE:
			food -= delta * IDLE_HUNGER

func _process(delta: float) -> void:
	%FoodLabel.text = "Food: "+str(int(food))
