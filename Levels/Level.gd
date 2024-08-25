extends Node
class_name Level

var debug_node : Node 
var options_node : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_node = find_node('debug')
	options_node = find_node('Options')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("options"):
		options_node.visible = !options_node.visible
		get_tree().paused  = !get_tree().paused 
	if event.is_action_pressed("debug"):
		if debug_node :
			debug_node.visible = !debug_node.visible
			

func find_node(nodeName) -> Node:
	var node_found = get_node(nodeName)
	if node_found :
		return node_found
	else:
		printerr("Couldn't find the \"" + nodeName + " \"node in the current scene. Check if the name of the nod has changed or if it is really missing in the scene.")
		return null
