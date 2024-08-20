extends CharacterBody2D

const SPEED : float = 500.0

func _ready() :
	$Bullet.free()

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	
	if velocity.length()>0:
		velocity = velocity.normalized()*SPEED
		
	move_and_slide()



func _on_hitbox_component_area_entered(area):
	if area is HitboxComponent :
		print("attack detected")
		var attack = Attack.new()
		area.launch_attack(attack)
