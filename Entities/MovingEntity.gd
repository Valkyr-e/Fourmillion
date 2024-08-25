extends CharacterBody2D
class_name MovingEntity
### Classe mère des classes Player et Enemy
###
### Permet de mettre en commun certains scripts liés notamment aux états car 
### Player comme Enemy peuvent partager un état (BeeingPushedFromPoint par exemple)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	manage_flip()


func deactivate_collision(custom_layer : int = 0, custom_mask : int = 0):
	set_meta("col_mask", collision_mask)
	set_meta("col_layer", collision_layer)
	collision_layer = custom_layer
	collision_mask = custom_mask 
	
	$HitboxComponent.set_meta("col_mask", $HitboxComponent.collision_mask)
	$HitboxComponent.set_meta("col_layer", $HitboxComponent.collision_layer)
	$HitboxComponent.collision_layer = custom_layer
	$HitboxComponent.collision_mask = custom_mask
			
			
func reactivate_collision():
	collision_mask = get_meta("col_mask")
	collision_layer = get_meta("col_layer")
	
	$HitboxComponent.collision_mask = $HitboxComponent.get_meta("col_mask")
	$HitboxComponent.collision_layer = $HitboxComponent.get_meta("col_layer")

func manage_flip():
	if velocity.x != 0 :
		$Sprite2D.flip_h = velocity.x < 0
