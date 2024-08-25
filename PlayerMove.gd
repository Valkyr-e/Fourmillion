extends State
class_name PlayerMove

@export var  SPEED : float = 500.0
@export var ACCELERATION :  float = 50.0
@export var DECELERATION : float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enter():
	moving_entity.get_node("AnimationPlayer").play("run")
	
func process(_delta):
	moving_entity.manage_flip()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta):
	var input_directions= moving_entity.get_directional_inputs().normalized()
	var vel = moving_entity.velocity
	if input_directions != Vector2.ZERO :
		vel = input_directions * min(vel.length()+ ACCELERATION,SPEED)
	elif vel != Vector2.ZERO : 
		var velocity_length = vel.length()
		vel = vel / velocity_length * max(velocity_length- DECELERATION,0)
	else :
		transitioned.emit("")
	moving_entity.velocity = vel
	moving_entity.move_and_slide()
	
