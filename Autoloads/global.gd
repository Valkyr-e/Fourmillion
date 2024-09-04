extends Node
### Pour le moment il n'y a qu'une fonction pour chercher un node à partir de son nom.
### Ca sera surement ici qu'on gèrera les sauvegardes, scenes, etc (+ tard)

func findNodeByName(nodeName):
	return get_tree().get_root().get_node(get_tree().current_scene.name +"/"+ nodeName)

### Gestion des collectibles

var tower_building_collectible_counter : int 
var tower_upgrading_collectible_counter : int


func _ready():
	tower_building_collectible_counter = 0
	tower_upgrading_collectible_counter = 0


func add_collectible_to_inventory(type : String) :
	#print("ça marche")
	if type == "tower building" :
		tower_building_collectible_counter += 1
		print("Tower building : ",tower_building_collectible_counter)
	elif type == "tower upgrading" :
		tower_upgrading_collectible_counter += 1
	#elif type == "healing" :
		#déclencher une fonction de heal avec un health component ou emission signal ?

func use_collectible(type : String,cost : int) :
	if type == "tower building" :
		tower_building_collectible_counter -= cost
		print("Tower building : ",tower_building_collectible_counter)
	elif type == "tower upgrading" :
		tower_upgrading_collectible_counter -= cost
