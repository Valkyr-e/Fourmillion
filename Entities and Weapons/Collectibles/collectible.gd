extends Area2D
class_name Collectible

var collectible_type : String = "tower building" #nommé selon l'utilité du collectible 
#autres types possibles plus tard : "tower upgrading" ; "healing" ; "player upgrading" ; "hp increasing" ; "damage increasing",...

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass


func _on_picked_up(body): 
	if body is Player :
		#print("ramassé")
		Global.add_collectible_to_inventory(collectible_type)
		queue_free()
