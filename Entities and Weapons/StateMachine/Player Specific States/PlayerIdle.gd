extends State
class_name PlayerIdle


func enter():
	moving_entity.get_node("AnimationPlayer").play("idle")
	
	
func _input(_event):
	if moving_entity.get_directional_inputs() != Vector2.ZERO:
		transitioned.emit("PlayerMove")
