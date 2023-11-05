class_name Enemy extends Area2D

signal laser_shot(elaser_scene, location)

@export var speed = 50

@onready var enemy = $"."

@onready var egun = $egun

@onready var timer = $ShootTimer

var elaser_scene = preload("res://scenes/elaser.tscn")

func _physics_process(delta):
	global_position.y += speed * delta 
	global_position.x += speed * delta 

func die():
	queue_free()
	
func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():  #have laser despawn on top of screen
	die()

func _ready():
	timer.wait_time = 1
	timer.start()

func _on_shoot_timer_timeout():
	var elaser = elaser_scene.instantiate()
	print("bang")
	enemy.add_child(elaser)
