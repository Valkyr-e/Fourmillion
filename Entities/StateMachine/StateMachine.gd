@icon("res://icons/state_machine_icon.png")

extends Node2D
class_name StateMachine

var current_state : State 
var states : Dictionary = {}

@export var moving_entity = PhysicsBody2D
@export var initial_state : State 
@export var default_state : State = initial_state


func _ready():
	if !moving_entity:
		printerr("Moving entity not found in state machine inspector.\
		 Make sure to add a PhysicsBody2D to the StateMachine.")
	
	for child in get_children():
		states[child.name.to_lower()] = child
		child.transitioned.connect(_on_state_transition)
		child.moving_entity = moving_entity
		print(child.name.to_lower())
		
	if initial_state:
		initial_state.enter()
		current_state = initial_state
	else :
		push_warning("no initial state in state machine of " + moving_entity.name)

func _process(delta):
	if current_state:
		current_state.process(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)
		
## Used in 2 ways : 
## if new_state != null, then changes the state to new_state.
## if new_state == null, then changes the state to default_state.
## This method can be used by children when they don't know which is the next state
func _on_state_transition(new_state : State):
	if current_state:
		current_state.exit()
	if !new_state : # if 
		new_state = default_state
	new_state.enter()
	current_state = new_state
	
	
	
