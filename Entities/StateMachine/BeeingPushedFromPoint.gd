@icon("res://icons/state_icon.png")

extends State
class_name BeeingPushedFromPoint
### State fait pour être repoussé depuis un point donné.
### Suit une trajectoire légèrement courbe dirigée par le vecteur entre la position
### du pussant et la position du poussé.
###
### On souhaite une poussée durant T (s), parcourant une distance D.


var position_pusher : Vector2
var force_pusher : float
var alpha_veloxity_main_axis_change : Vector2
var initial_velocity : Vector2
var distance_from_push_to_land : float
var entity_main_velocity : Vector2 = Vector2.ZERO
var entity_normal_velocity : Vector2 = Vector2.ZERO
var is_ended :bool  = false

@export var time_pushed : float = 0.5
@export var base_distance_from_push_to_land : float = 100.0
@export var initial_velocity_strength : float = 10.0 

func velocity_calculations(delta : float):
	entity_main_velocity += alpha_veloxity_main_axis_change*delta
	entity_normal_velocity = entity_normal_velocity
	
	moving_entity.velocity = entity_main_velocity + entity_normal_velocity
	
	if entity_main_velocity.dot(initial_velocity) <= 0 :
		is_ended = true
		transitioned.emit(null)
		moving_entity.velocity = Vector2.ZERO
	
	
	
# Called when the state machine changes its state to this one
func enter():
	if moving_entity is Player:
		moving_entity.lose_control()
	var direction_pushed = moving_entity.global_position - position_pusher
	var length_pushed =  direction_pushed.length()
	var push_proximity = 1/clamp(length_pushed/64, 0.3 , 1)
	distance_from_push_to_land = push_proximity * base_distance_from_push_to_land
	
	moving_entity.deactivate_collision(0,8) # no layer (0) but mask = terrain (8)
	
	initial_velocity = direction_pushed/length_pushed*2*distance_from_push_to_land/time_pushed
	entity_main_velocity = initial_velocity
	
	alpha_veloxity_main_axis_change = -initial_velocity/time_pushed 
	is_ended = false

# Called when the state machine changes its state from this one to another one
func exit():
	moving_entity.reactivate_collision()
	if moving_entity is Player:
		moving_entity.regain_control()
	print("est passé dans exit")


# Called in _physics_update() of the StateMachine when this state is active
# This is NOT _physics_update()
func physics_process(delta):
	velocity_calculations(delta)
	moving_entity.move_and_slide()

func is_retrievable():
	return false

func get_is_ended():
	return is_ended
