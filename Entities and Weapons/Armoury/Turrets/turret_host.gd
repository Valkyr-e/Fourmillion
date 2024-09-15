extends Node2D
class_name TurretHost
var player_is_in : bool = false
@export var turret : PackedScene
var turret_cost : int 

func _ready():
	turret_cost = 1


func _input(_event): #fait apparaître une tourelle
	if Input.is_action_just_pressed("interact") and player_is_in:
		if Global.tower_building_collectible_counter >= turret_cost :
			Global.use_collectible("tower building", turret_cost)
			var instantiated_turret = turret.instantiate()
			instantiated_turret.global_position = global_position
			get_tree().get_root().add_child(instantiated_turret)
			await on_turret_host_activated()
			queue_free()
		
func on_turret_host_activated():
	$Label.hide()
	# Animation d'activation, ...
	
func _on_area_2d_body_entered(body):
	player_is_in = true
	if body is Player :
		$Label.show()



func _on_area_2d_body_exited(body):
	player_is_in = false
	if body is Player :
		$Label.hide()
