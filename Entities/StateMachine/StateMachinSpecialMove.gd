extends StateMachine
class_name StateMachineSpecialMove

var timer_special_move : float

@export var special_move_cooldown : float = 1.0
@export var special_move_state : SpecialMoveState

# Called when the node enters the scene tree for the first time.
func _ready():
	connect_children()
	initialization()
	timer_special_move = special_move_cooldown
	
func _process(delta):
	if current_state:
		current_state.process(delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not (current_state is SpecialMoveState or current_state is IdleState or current_state is DoNothingState):
		timer_special_move -= delta
		if timer_special_move <= 0 :
			timer_special_move = special_move_cooldown
			special_move_state.target = current_state.target ##Attention, ne fonctionne que si l'entity est en follow
			interrupted_state = current_state
			_on_state_transition(special_move_state)
			
	if current_state:
		current_state.physics_process(delta)
