extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var attack_component : Attack

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func launch_attack(attack : Attack) :
	if health_component :
		health_component.on_attack(attack)
	

func _on_area_entered(area):
	if area is HitboxComponent :
		#print("attack detected")
		var attack : Attack
		if attack_component :
			attack = attack_component
		else :
			attack = Attack.new()
		#attack.damage = on peut ajuster si on veut
		area.launch_attack(attack)
