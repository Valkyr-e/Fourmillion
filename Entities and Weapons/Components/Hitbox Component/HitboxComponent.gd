@icon("res://Icons/hitbox_component_icon.png")

extends Area2D
class_name HitboxComponent

var is_attack_ready : bool = true
var attack_reset_timer : Timer

@export var health_component : HealthComponent
@export var attack_component : AttackComponent
@export var attack_reset_time : float = 0.5 # time between two attacks


func _ready():
	attack_reset_timer = Timer.new() 
	attack_reset_timer.autostart = false
	attack_reset_timer.one_shot = true
	attack_reset_timer.timeout.connect(_on_attack_reset)
	add_child(attack_reset_timer)

func _on_attack_reset():
	is_attack_ready = true
	for area in get_overlapping_areas():
		handle_attack(area)
	
func _process(_delta):
	pass


func launch_attack(attack : AttackComponent) :
	if health_component :
		health_component.on_attack(attack)

func _on_area_entered(area):
	handle_attack(area)

		
func handle_attack(area):
	if area is HitboxComponent :
		if attack_component and is_attack_ready:
			area.launch_attack(attack_component)
			attack_reset_timer.wait_time = attack_reset_time
			attack_reset_timer.start()
