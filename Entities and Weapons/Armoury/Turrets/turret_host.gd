extends Node2D
class_name TurretHost
var player_is_in : bool = false
@export var turret : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if Input.is_action_just_pressed("interact") and player_is_in:
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
