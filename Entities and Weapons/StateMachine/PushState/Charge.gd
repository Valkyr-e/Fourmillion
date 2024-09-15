extends PushState
class_name Charge


var charge_duration : float
var charge_velocity : Vector2
var target : Node2D
var is_ended : bool = true
var charge_target_position : Vector2

var timer : Timer
var current_phase : int 
var debug_start_charge_position : Vector2 
var state_active_debug : bool = false

enum ChargePhase {BEFORE , CHARGE , AFTER}


@export var time_before_charge : float = .9
@export var charging_speed : float = 500.0
@export var time_after_charge : float = 1.0
@export var max_distance_to_charge : float = 500.0


func _ready():
	attack_component = AttackComponent.new()
	print("attack_component " , attack_component )
	
	timer =Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.timeout.connect(_on_timeout)
	timer.set_timer_process_callback(Timer.TIMER_PROCESS_PHYSICS)
	add_child(timer)
	debug_start_charge_position = global_position
	
	
	
# Called when the node enters the scene tree for the first time.
func enter():
	print("dans enter, target : ", target.name)
	var direction_to_target = target.global_position-moving_entity.global_position
	var distance_to_targer = direction_to_target.length()
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(moving_entity.global_position, target.global_position,8, [self])
	var result = space_state.intersect_ray(query)
	if distance_to_targer < max_distance_to_charge and result == {}:
		timer.set_wait_time(time_before_charge)
		timer.start()
		charge_duration = max_distance_to_charge/charging_speed
		charge_velocity = direction_to_target.normalized()*max_distance_to_charge/charge_duration
		moving_entity.get_node("AnimationPlayer").play("before_charge")
		is_ended = false
		current_phase = ChargePhase.BEFORE
		charge_target_position = global_position + charge_velocity*charge_duration
	else :
		transitioned.emit("")
	
	
	
func _on_timeout():
	if current_phase == ChargePhase.AFTER :
		moving_entity.get_node("AnimationPlayer").play("base")
		is_ended = true
		transitioned.emit("")	
	elif current_phase == ChargePhase.CHARGE:
		moving_entity.get_node("AnimationPlayer").play("after_charge")
		current_phase = ChargePhase.AFTER
		timer.wait_time = time_after_charge
		timer.start()
	elif current_phase == ChargePhase.BEFORE:
		# state_active_debug = true  #remettre pour voir le trait de la charge
		moving_entity.get_node("AnimationPlayer").play("charge")
		current_phase = ChargePhase.CHARGE
		timer.wait_time = charge_duration
		timer.start()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta):
	moving_entity.velocity = Vector2.ZERO
	queue_redraw()
	if current_phase == ChargePhase.CHARGE:
		overlapping_bodies = push_area.get_overlapping_bodies()
		moving_entity.velocity = charge_velocity 
		push_all_bodies()
	moving_entity.move_and_slide()	

func exit():
	queue_redraw()
	state_active_debug = false
	

func _draw():
	if state_active_debug  :
		draw_line(Vector2.ZERO, charge_target_position - global_position, Color.RED ,  5)
	
func is_retrievable():
	return false

func get_is_ended():
	return is_ended
