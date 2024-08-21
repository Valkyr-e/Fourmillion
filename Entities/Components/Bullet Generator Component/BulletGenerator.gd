extends Node2D
class_name BulletGenerator

#signal bullet_launched(bullet_scene)

@export var bullet : PackedScene
@export var detection_radius : float = 300.0

var RESET_TIME : float = 0.5
var nearest_enemy : Enemy = null #ATTENTION plutôt character2D car sinon un ennemi ne peut pas l'utiliser ?
var enemies : Array[CharacterBody2D]


func _ready():
	#Initialise la taille de l'aire de détection
	$CollisionShape2D.shape.radius = detection_radius
	print($CollisionShape2D.get_shape().radius)
	
	#Initialise la durée du timer entre chaque tir
	$ResetTimer.wait_time = RESET_TIME


func _physics_process(delta):
	pass

func _on_reset_timer_timeout():
	if enemies != [] :
		find_nearest_enemy()
		shoot_bullet(bullet)
		clean_enemy_list(enemies) #remove dead enemies from the list
		#print(nearest_enemy)

func _on_area_entered(area):
	enemies.append(area.get_parent())
	#print(enemies)

func _on_area_exited(area):
	enemies.erase(area.get_parent())

func shoot_bullet(bullet_type : PackedScene) :
	var bullet_instance = bullet_type.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_position = global_position
	bullet_instance.initialization(nearest_enemy,global_position)
	

func find_nearest_enemy() :
	nearest_enemy = enemies[0]
	var shortest_distance_squared : float = nearest_enemy.global_position.distance_squared_to(global_position)
	for i in range (1,len(enemies)):
		var pretender = enemies[i]
		var pretender_distance_squared : float = pretender.global_position.distance_squared_to(global_position)
		if pretender_distance_squared < shortest_distance_squared :
			nearest_enemy = pretender
			shortest_distance_squared = pretender_distance_squared

func clean_enemy_list(enemy_list : Array[CharacterBody2D]) :
	for _e in enemy_list :
		if str(_e) == "<Freed Object>":
			enemy_list.erase(_e)
		
