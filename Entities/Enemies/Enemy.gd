extends MovingEntity
class_name Enemy

@export var WANDER_SPEED = 50.0
@export var SPEED = 300.0

func _process(_delta):
	manage_flip()
	
func _physics_process(_delta):
	pass


