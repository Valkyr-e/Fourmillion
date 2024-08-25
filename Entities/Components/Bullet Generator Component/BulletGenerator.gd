@icon("res://icons/bullet_generator_icon.png")

extends Node2D
class_name BulletGenerator


var nearest_enemy : CharacterBody2D = null #ATTENTION plutôt character2D car sinon un ennemi ne peut pas l'utiliser ?
var enemies : Array[CharacterBody2D]
var is_active : bool = false

@export var bullet : PackedScene
@export var detection_radius : float = 300.0
@export var RESET_TIME : float = 0.5




func _ready():
	#Initialise la taille de l'aire de détection
	$CollisionShape2D.shape.radius = detection_radius
	
	#Initialise la durée du timer entre chaque tir
	$ResetTimer.wait_time = RESET_TIME


func set_activation(b : bool):
	is_active = b
	
func _physics_process(_delta):
	pass

func _on_reset_timer_timeout():
	if enemies != [] and is_active:
		find_nearest_enemy()
		shoot_bullet(bullet)
	clean_enemy_list(enemies) #remove dead enemies from the list


func _on_area_entered(area):
	var parent = area.get_parent()
	if parent is CharacterBody2D:
		enemies.append(parent)


func _on_area_exited(area):
	var parent = area.get_parent()
	if parent is CharacterBody2D:
		enemies.erase(parent)

func shoot_bullet(bullet_type : PackedScene) :
	var bullet_instance = bullet_type.instantiate()
	get_tree().current_scene.add_child(bullet_instance)
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
		
