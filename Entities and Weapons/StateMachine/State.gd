@icon("res://Icons/state_icon.png")

extends Node2D
class_name State
# 
var moving_entity : PhysicsBody2D

# signal emited when the state changes from : self to next_state
signal transitioned(next_state : State) 


# Called when the state machine changes its state to this one
func enter():
	pass 

# Called when the state machine changes its state from this one to another one
func exit():
	pass 

# Called in _process() of the StateMachine when this state is active
# This is NOT _process()
func process(_delta):
	pass
	
# Called in _physics_update() of the StateMachine when this state is active
# This is NOT _physics_update()
func physics_process(_delta):
	pass

func is_retrievable():
	return true

func get_is_ended():
	return true
