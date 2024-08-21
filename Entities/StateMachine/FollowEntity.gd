
extends State
class_name FollowEntity

var target_node = null

@export var layer_to_follow : int = 1 # Follow the physics layer 1 by default
@export var aggro_distance: float = 100
@export var stop_aggro_distance : float = 150

var timer : Timer
var time_recalculate_path : float = .3

var navigation_agent : NavigationAgent2D

func _ready():
	initialize_navigation()
	
func initialize_navigation():
	navigation_agent = $NavigationComponent/NavigationAgent2D 
	
	$NavigationComponent/Aggro.body_entered.connect(_on_aggro_body_entered)
	$NavigationComponent/StopAggro.body_exited.connect(_on_stop_aggro_body_exited)
	
	$NavigationComponent/Aggro/AggroShape.shape.radius = aggro_distance
	$NavigationComponent/StopAggro/StopAggroShape.shape.radius = stop_aggro_distance
	
	navigation_agent.path_desired_distance = 4
	navigation_agent.target_desired_distance = 4
	
	timer = Timer.new()
	timer.wait_time  = time_recalculate_path
	timer.autostart = true
	timer.timeout.connect(_on_recalculate_navigation_timeout)
	add_child(timer)
	
func physics_process(_delta):
	if not navigation_agent.is_navigation_finished():
		print("en train de chercher")
		var axis : Vector2 = to_local(navigation_agent.get_next_path_position()).normalized()
		moving_entity.velocity = axis*moving_entity.SPEED
		moving_entity.move_and_slide()

func recalculate_path():
	if target_node:
		navigation_agent.target_position = target_node.global_position
		

func _on_recalculate_navigation_timeout():
	recalculate_path()



func _on_aggro_body_entered(body):
	if body.get_collision_layer_value(layer_to_follow)   and ! target_node:
		target_node = body
		transitioned.emit(self)


func _on_stop_aggro_body_exited(body):
	if body ==  target_node:
		target_node = null
		transitioned.emit(null)
