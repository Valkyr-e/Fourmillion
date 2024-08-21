@icon("res://icons/health_component_icon.png")

extends Node
class_name HealthComponent

@export var MAX_HEALTH = 100
var health : float

signal just_died


func _ready():
	health = MAX_HEALTH

func _process(delta):
	pass

func on_attack(attack : Attack) :
	var damage = attack.DEFAULT_ATTACK_DAMAGE #dégât par défaut
	if attack.damage :
		damage = attack.damage
	health -= damage
	if health <= 0 :
		#print("deadge")
		just_died.emit()
		
func _on_just_died():
	var parent = get_parent()
	if parent is Enemy :
		parent.queue_free() 
	elif parent is Player :
		print("GAME OVER BRO")
		parent.queue_free() 



