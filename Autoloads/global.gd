extends Node
### Pour le moment il n'y a qu'une fonction pour chercher un node à partir de son nom.
### Ca sera surement ici qu'on gèrera les sauvegardes, scenes, etc (+ tard)

func findNodeByName(nodeName):
	return get_tree().get_root().get_node(get_tree().current_scene.name +"/"+ nodeName)
	

			
