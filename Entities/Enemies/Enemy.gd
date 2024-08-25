extends MovingEntity
class_name Enemy

@export var WANDER_SPEED = 50.0
@export var SPEED = 300.0

func _process(_delta):
	manage_flip()
	
func _physics_process(_delta):
	pass

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent :
		var attack = AttackComponent.new()
		attack.damage = 10
		area.launch_attack(attack)

