
extends State
class_name FollowEntity

var target = null
var timer : Timer
var time_recalculate_path : float = .3
var navigation_agent : NavigationAgent2D
var current_aggro_distance : float
var current_stop_aggro_distance : float

static var sneak : bool = true
static var need_to_actualize_follow_distance : bool = false

@export var layer_to_follow : int = 1 # Follow the physics layer 1 by default
@export var aggro_distance: float = 300
@export var stop_aggro_distance : float = 500
@export var aggro_distance_sneak: float = 50
@export var stop_aggro_distance_sneak : float = 100



func _ready():
	initialize_navigation()
	current_aggro_distance = aggro_distance_sneak
	current_stop_aggro_distance = stop_aggro_distance_sneak
	
# fonction utilisée en même temps par tous les FollowEntity
static func set_need_actualize_follow_distances(is_sneaking : bool):
	sneak = is_sneaking # inverse la valeur de sneak
	need_to_actualize_follow_distance = true
	
func actualize_follow_distances():
	if sneak :
		current_aggro_distance = aggro_distance_sneak
		current_stop_aggro_distance = stop_aggro_distance_sneak
	else :
		current_aggro_distance = aggro_distance
		current_stop_aggro_distance = stop_aggro_distance
	$NavigationComponent/Aggro/AggroShape.shape.radius = current_aggro_distance
	$NavigationComponent/StopAggro/StopAggroShape.shape.radius = current_stop_aggro_distance
	
	if $NavigationComponent/Aggro.get_overlapping_bodies() != []:
		target = $NavigationComponent/Aggro.get_overlapping_bodies()[0]
	else : 
		target = null
		transitioned.emit("")
		
func initialize_navigation():
	navigation_agent = $NavigationComponent/NavigationAgent2D 
	
	$NavigationComponent/Aggro.body_entered.connect(_on_aggro_body_entered)
	$NavigationComponent/StopAggro.body_exited.connect(_on_stop_aggro_body_exited)
	
	actualize_follow_distances()
	
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	
	timer = Timer.new()
	timer.wait_time  = time_recalculate_path
	timer.autostart = true
	timer.timeout.connect(_on_recalculate_navigation_timeout)
	add_child(timer)
	
	
func _process(_delta):
	# Passage en cas de demande de changement de distances sur
	# tous les FollowingEntity
	if need_to_actualize_follow_distance:
		need_to_actualize_follow_distance = false
		actualize_follow_distances()


func physics_process(_delta):
	
	if not navigation_agent.is_navigation_finished():
		var axis : Vector2 = to_local(navigation_agent.get_next_path_position()).normalized()
		moving_entity.velocity = axis*moving_entity.SPEED
		moving_entity.move_and_slide()

func recalculate_path():
	if target:
		navigation_agent.target_position = target.global_position
		

func _on_recalculate_navigation_timeout():
	recalculate_path()



func _on_aggro_body_entered(body):
	if body.get_collision_layer_value(layer_to_follow)   and ! target:	
		target = body
		transitioned.emit("FollowEntity")


func _on_stop_aggro_body_exited(body):
	if body ==  target:
		target = null
		transitioned.emit("")

func is_retrievable():
	return (target is CharacterBody2D)
