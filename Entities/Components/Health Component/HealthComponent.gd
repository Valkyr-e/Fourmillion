extends Node
class_name HealthComponent

@export var MAX_HEALTH = 100
var health : float

var alive : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	health = MAX_HEALTH
	alive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_hit(attack : Attack) :
	var damage = attack.BASIC_ATTACK_DAMAGE
	if attack.damage != 0 :
		damage = attack.damage
	health -= damage
	if health <= 0 :
		print("deadge")
		alive = false
		get_parent().queue_free() #ATTENTION tue aussi le player...
