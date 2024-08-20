extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#func _on_body_entered(body):
	#if body.collision_layer == 2 : #2 pour Enemy
		#print(collision_layer,"SUS AU CRABES")

func launch_attack(attack : Attack) :
	if health_component :
		health_component.on_hit(attack)
	
