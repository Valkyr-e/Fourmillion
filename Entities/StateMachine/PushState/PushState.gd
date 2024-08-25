extends SpecialMoveState
class_name PushState

var overlapping_bodies : Array[Node2D]

var attack_component : AttackComponent 
@export var push_area : Area2D
@export var push_damage : int = 50
# Called when the node enters the scene tree for the first time.


func _ready():
	attack_component = AttackComponent.new().init()

func physics_process(_delta):
	overlapping_bodies = push_area.get_overlapping_bodies()
	push_all_bodies()
	transitioned.emit("")
	
	
func push(body):
	var pushed_state = body.get_node("StateMachine/BeeingPushedFromPoint")
	if pushed_state :
		pushed_state.position_pusher = self.global_position
		pushed_state.transitioned.emit("BeeingPushedFromPoint")
		
func push_all_bodies():
	for body in overlapping_bodies:
		if body != moving_entity:
			push(body)
			var hitbox_component = body.get_node("HitboxComponent")
			if hitbox_component and attack_component:
				
				hitbox_component.launch_attack(attack_component)
			
			

func is_retrievable():
	return true
	
func get_is_ended():
	return true
