extends Node2D
class_name WaveManager

var number_of_waves : int
var current_wave : int = 0
var wave_phase = true
var pause_phase = false
var current_wave_events : Array[WaveEvent]
var current_wave_time : float = 0.0
var previous_wave_time : float = 0.0
var spawn_locations_list : Array[Vector2]
var number_spawn_locations : int
var rng = RandomNumberGenerator.new()

@export var pause_between_waves : float = 20.0
@export var waves : Array[WaveRessource]
@export var player : Player


# Called when the node enters the scene tree for the first time.
func _ready():
	number_of_waves = len(waves)

	$Wave_Timer.timeout.connect(_on_wave_ended)
	$Pause_Timer.timeout.connect(_on_wave_start)
	$Pause_Timer.wait_time = pause_between_waves
	
	for child in get_children():
		if not (child is Timer) :
			spawn_locations_list.append(child.global_position)
	number_spawn_locations = len(spawn_locations_list)
	_on_wave_start()
	
func _process(delta):
	if wave_phase:
		current_wave_time = waves[current_wave].duration- $Wave_Timer.time_left
		for event in current_wave_events:
			manage_event(event,current_wave_time, previous_wave_time)
		previous_wave_time = current_wave_time


func manage_event(event, current_time, previous_time):
	var spawn_frequency : float = (event.end - event.begin)/event.number
	var last_spawn_time : float = int(current_time/spawn_frequency)*spawn_frequency
	if previous_time <= last_spawn_time and last_spawn_time <= current_time:
		spawn_enemy(event.enemy) 
		
func spawn_enemy(enemy):
	var spawn_position = spawn_locations_list[rng.randi_range(0,number_spawn_locations-1)]
	var enemy_instance = enemy.instantiate()
	get_tree().current_scene.add_child(enemy_instance)
	enemy_instance.global_position = spawn_position
	enemy_instance.get_node("StateMachine/FollowEntity").set_target( player )


func _on_wave_start():
	current_wave_events = waves[current_wave].event_list
	$Wave_Timer.wait_time = waves[current_wave].duration
	$Wave_Timer.start()	
	$Pause_Timer.stop()
	wave_phase = true
	pause_phase = false
	print("wave " , current_wave , " started")
	 
func _on_wave_ended():
	current_wave += 1 
	if current_wave > number_of_waves : 
		_on_all_waves_ended()
		return null
	$Wave_Timer.stop()
	$Pause_Timer.start()
	wave_phase = false
	pause_phase = true
	print("pause started")
	
func _on_all_waves_ended():
	print("GG WP")
	wave_phase = false
