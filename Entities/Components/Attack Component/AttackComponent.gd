@icon("res://icons/attack_component_icon.png")

extends Node
class_name AttackComponent

@export var ATTACK_DAMAGE = 50 # damage par défaut si le damage n'est pas précisé

func init(init_damage : int = 50 ):
	ATTACK_DAMAGE = init_damage
	return self

func _ready():
	pass 

func _process(_delta):
	pass

