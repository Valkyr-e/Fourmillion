@icon("res://icons/hitbox_component_icon.png")

extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent
@export var attack_component : AttackComponent

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass


func launch_attack(attack : AttackComponent) :
	if health_component :
		health_component.on_attack(attack)
	

func _on_area_entered(area):
	if area is HitboxComponent :
		var attack : AttackComponent
		if attack_component :
			attack = attack_component
		else :
			attack = AttackComponent.new()
		#attack.damage = on peut ajuster si on veut
		area.launch_attack(attack)
