extends PushState
class_name PushAndDamage


func physics_process(_delta):
	overlapping_bodies = push_area.get_overlapping_bodies()
	push_all_bodies()
	transitioned.emit(null)
	
	# Ajouter Damage

func is_retrievable():
	return false

func get_is_ended():
	return true
