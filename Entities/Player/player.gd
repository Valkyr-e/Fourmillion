extends MovingEntity
class_name Player


var is_sneaking : bool = true

@export var weapon : BulletGenerator 

func _ready() :
	pass

func _process(_delta):
	pass
	
func _input(_event):
	if Input.is_action_just_pressed("weapon"):
		is_sneaking = !is_sneaking
		weapon.set_activation(!is_sneaking) # activate if not sneaking
		FollowEntity.set_need_actualize_follow_distances(is_sneaking)
		

	
func get_directional_inputs() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
