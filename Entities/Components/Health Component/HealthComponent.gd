@icon("res://icons/health_component_icon.png")

extends Node
class_name HealthComponent


class HealthInfo :
	var health : float
	var max_health : float

	func _init(_health, _max_health):
		health = _health
		max_health = _max_health
		
	func healthbar_value() -> float : 
		return clamp(health/max_health*100,10,100)
		
		
@export var barre_de_vie : TextureProgressBar
@export var MAX_HEALTH = 100
var health_info : HealthInfo

signal healthbar_needs_change(healthbar_value : float)
signal just_died




func _ready():
	health_info= HealthInfo.new(MAX_HEALTH, MAX_HEALTH) 

func _process(_delta):
	pass

func on_attack(attack : AttackComponent) :
	health_info.health -= attack.ATTACK_DAMAGE
	if health_info.health <= 0 :
		just_died.emit()
	if get_parent() is Player :
		healthbar_needs_change.emit(health_info.healthbar_value())
	
func _on_just_died():
	var parent = get_parent()
	if parent is Enemy :
		parent.queue_free() 
	elif parent is Player :
		parent.queue_free() 
