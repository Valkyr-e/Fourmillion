extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if get_parent().get_node("StateMachine").current_state.get_is_ended():
		text = get_parent().get_node("StateMachine").current_state.name #+ " ;  FINI " 
	else : 
		text = get_parent().get_node("StateMachine").current_state.name #+ " ;  EN COURS" 
