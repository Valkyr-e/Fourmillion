extends CanvasLayer

@export var player : Player
@export var healthbar : TextureProgressBar
@export var player_state : Sprite2D

func _ready():
	player.get_node("HealthComponent").healthbar_needs_change.connect(_on_helthbar_needs_change)
	player.get_node("BulletGenerator").weapon_changed_state.connect(_on_weapon_change_state)

func _process(delta):
	$TowerBuildingCollLabel.text = str(Global.tower_building_collectible_counter)
	
func _on_helthbar_needs_change(healthbar_value : float):
	healthbar.value = healthbar_value
	
func _on_weapon_change_state(b : bool):
	player_state.frame = 1- player_state.frame
