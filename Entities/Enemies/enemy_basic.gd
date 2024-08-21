extends CharacterBody2D
class_name Enemy

@export var WANDER_SPEED = 50.0
@export var SPEED = 300.0


func _physics_process(_delta):
	pass

func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent :
		print("touché")
		var attack = Attack.new()
		attack.damage = 10
		area.launch_attack(attack)
