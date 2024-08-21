extends Node

# Script global pour permettre la gestion des scènes

func findNodeByName(nodeName):
	return get_tree().get_root().get_node(get_tree().current_scene.name +"/"+ nodeName)
	

			
