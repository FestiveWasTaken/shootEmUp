extends Node2D

@export var enemy_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPosition
@onready var laser_container = $LaserContainer
@onready var timer = $ShootTimer
@onready var enemytimer = $EnemySpawnTimer
@onready var enemycontainer = $EnemyContainer
@onready var pb = $ParallaxBackground
var player = null
var scroll_speed = 100

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.laser_shot.connect(_on_player_laser_shot)

func _process(delta):
	pb.scroll_offset.y += delta*scroll_speed

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)

func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(40,500), 0)
	enemycontainer.add_child(e)
