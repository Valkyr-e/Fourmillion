extends State
class_name Idle

var moving_entity_velocity : Vector2
var timer_wander : Timer



@export_group("Wandering Time limits")
@export var time_wander_change_min : float = 1.0
@export var time_wander_change_max : float = 2.0

@export_group("Origin Point")
@export var clamp_distance : float = 50.0
@export var bias_to_origin : bool = true
@export var origin_bias_weight : float = 0.4 # between 0 (no bias) and 1 (always moves towards the origin position):

@export var other_states_to_transition_to : Array[State]

var origin_position : Vector2 
		
		
func enter():
	origin_position = moving_entity.global_position
	
	timer_wander = Timer.new()
	_on_wander_timeout() # set initial direction and wander time
	timer_wander.autostart = true
	add_child(timer_wander)
	timer_wander.timeout.connect(_on_wander_timeout)

	
	
func exit():
	timer_wander.queue_free()
	
	
func process(_delta):
	pass

func physics_process(_delta):
	moving_entity.velocity = moving_entity_velocity
	var collision_info = moving_entity.move_and_slide()
	if collision_info:
		_on_wander_timeout()
	# Clamp moving_entity position
	moving_entity.position.x = clamp(moving_entity.position.x, origin_position.x - clamp_distance, origin_position.x + clamp_distance)
	moving_entity.position.y = clamp(moving_entity.position.y, origin_position.y - clamp_distance, origin_position.y + clamp_distance)

func _on_wander_timeout():
	var rand_vector = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	if bias_to_origin:
		var to_origin = (origin_position - moving_entity.global_position).normalized()
		moving_entity_velocity = (to_origin*origin_bias_weight + rand_vector*(1-origin_bias_weight)).normalized()*moving_entity.WANDER_SPEED
	else :	
		moving_entity_velocity = rand_vector*moving_entity.WANDER_SPEED
	timer_wander.wait_time = randf_range(time_wander_change_min,time_wander_change_max)

