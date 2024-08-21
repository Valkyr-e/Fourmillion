extends CharacterBody2D
class_name Bullet 

var SPEED : float = 200.0
var HOMING : bool = true
var LIFETIME : float = 10.0

var target : CharacterBody2D
var collision_info
var sprite_is_flipped : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(LIFETIME).timeout
	on_life_end()


func initialization(_target : CharacterBody2D,start_position : Vector2) :
	target = _target
	velocity = (target.global_position - start_position).normalized()*SPEED

func _physics_process(delta):
	if HOMING && str(target) != "<Freed Object>":
		velocity = (target.global_position - global_position).normalized()*SPEED
	
		rotation = velocity.angle() #change la sprite de sens selon la direction
	
	collision_info = move_and_collide(velocity*delta)
	if collision_info is KinematicCollision2D:
		#if collision_info.get_collider() is Enemy : #ATTENTION cette partie sera remplacée par les components
			##collision_info.get_collider()._on_hit(DAMAGE)
			#print("Touché")
		on_life_end()

func on_life_end() :
	queue_free()
