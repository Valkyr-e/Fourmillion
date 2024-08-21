extends CharacterBody2D
class_name Enemy

const SPEED = 300.0


func _physics_process(delta):
	pass



func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent :
		print("touché")
		var attack = Attack.new()
		attack.damage = 10
		area.launch_attack(attack)
