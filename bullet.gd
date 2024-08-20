extends CharacterBody2D
class_name Bullet 

var SPEED : float = 200.0
var HOMING : bool = true

var target : CharacterBody2D
var collision_info

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func initialization(_target : CharacterBody2D,start_position : Vector2) :
	target = _target
	velocity = (target.global_position - start_position).normalized()*SPEED

func _physics_process(delta):
	if HOMING && str(target) != "<Freed Object>":
		velocity = (target.global_position - global_position).normalized()*SPEED
	collision_info = move_and_collide(velocity*delta)
	if collision_info is KinematicCollision2D:
		if collision_info.get_collider() is Enemy :
			#collision_info.get_collider()._on_hit(DAMAGE)
			print("Touché")
		queue_free()


