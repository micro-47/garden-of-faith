extends CharacterBody2D

class_name Villager

# for simplicity, I made it so that food is shared amongst the whole village. When this becomes zero, everyone's health goes down.
static var food: float = 10.

var health: float = 10.


# finite state machine (https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/)
enum VillagerActionStates {WALK, IDLE, EAT}
@export
var state: VillagerActionStates = VillagerActionStates.IDLE

# too nice?
const WALK_HUNGER: float = 0.25
const IDLE_HUNGER: float = 0.125
# less than 1 means damage is slower than hunger
const HUNGER_DAMAGE_FACTOR: float = 0.25

const SPEED: float = 300.0


# only makes sense in the WALK state
@export
var destination: Vector2 = Vector2.ZERO


func _physics_process(delta: float) -> void:
	match state:
		VillagerActionStates.WALK:
			if position.distance_squared_to(destination) < 1:
				position = destination
				state = VillagerActionStates.IDLE
				take_hunger(delta * IDLE_HUNGER)
				return
			
			var direction := position.direction_to(destination)
			velocity = direction * SPEED
			
			if position.distance_to(destination) < 10:
				# dampen
				velocity *= sqrt(position.distance_to(destination) / 10)

			move_and_slide()
			
			# walking costs food
			take_hunger(delta * WALK_HUNGER)
		VillagerActionStates.IDLE:
			take_hunger(delta * IDLE_HUNGER)


# tries to take food, and if the new food is negative, then villager pays with health
# made it so that health is lost 4x slower than food, just because health is out of 10
func take_hunger(amount: float) -> void:
	food -= amount
	if food < 0:
		take_damage(-food * HUNGER_DAMAGE_FACTOR)
		food = 0.


func take_damage(amount: float) -> void:
	health -= amount
	if health < 0:
		queue_free()

func _process(delta: float) -> void:
	%HealthLabel.text = "Health: "+str(int(health))
