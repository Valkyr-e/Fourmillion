extends MovingEntity
class_name Player

@export var  SPEED : float = 500.0

var in_control : bool = true
var is_sneaking : bool = true

@export var weapon : BulletGenerator 

func _ready() :
	pass

func get_directional_inputs() -> Vector2:
	var inputs : Vector2 =  Vector2.ZERO
	if in_control :
		inputs = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return inputs
	
func _input(event):
	if Input.is_action_just_pressed("weapon"):
		is_sneaking = !is_sneaking
		weapon.set_activation(!is_sneaking) # activate if not sneaking
		FollowEntity.set_need_actualize_follow_distances(is_sneaking)
		
		
func _process(_delta):
	manage_flip()
		
func _physics_process(_delta):
	velocity = get_directional_inputs()
	
	if velocity.length()>0:
		velocity = velocity.normalized()*SPEED
		
	move_and_slide()
	


func lose_control():
	in_control = false
	
func regain_control():
	in_control = true

