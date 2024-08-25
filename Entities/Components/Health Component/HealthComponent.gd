@icon("res://icons/health_component_icon.png")

extends Node
class_name HealthComponent

@export var barre_de_vie : TextureProgressBar
@export var MAX_HEALTH = 100
var health : float

signal just_died


func _ready():
	health = MAX_HEALTH

func _process(_delta):
	pass

func on_attack(attack : AttackComponent) :
	var damage = attack.DEFAULT_ATTACK_DAMAGE #dégsât par défaut
	if attack.damage :
		damage = attack.damage
	health -= damage
	if health <= 0 :
		just_died.emit()
	if barre_de_vie:
		barre_de_vie.value = clamp(health/MAX_HEALTH*100,0.1,1.0)
		print(barre_de_vie.value)
		
func _on_just_died():
	var parent = get_parent()
	if parent is Enemy :
		parent.queue_free() 
	elif parent is Player :
		print("GAME OVER BRO")
		parent.queue_free() 



