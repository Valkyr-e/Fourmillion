@icon("res://icons/attack_component_icon.png")

extends Node
class_name AttackComponent

@export var DEFAULT_ATTACK_DAMAGE = 50 # damage par défaut si le damage n'est pas précisé
var damage : int 

func init(init_damage : int = 50 ):
	damage = init_damage
	return self

func _ready():
	pass 

func _process(_delta):
	pass

