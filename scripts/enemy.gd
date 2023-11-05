class_name Enemy extends Area2D

signal laser_shot(elaser_scene, location)

@export var downspeed = 50
@export var sidespeed = 50
@export var shootspeed = 1.5

@onready var enemy = $"."

@onready var egun = $egun

@onready var timer = $ShootTimer

var elaser_scene = preload("res://scenes/elaser.tscn")
var explosion_scene = preload("res://scenes/explosion.tscn")


func _physics_process(delta):
	global_position.y += downspeed * delta 
	global_position.x += sidespeed * delta 

func die():
	queue_free()
	var effect = explosion_scene.instantiate()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)
	
	
func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

func _on_visible_on_screen_notifier_2d_screen_exited():  #have laser despawn on top of screen
	die()

func _ready():
	timer.wait_time = shootspeed
	timer.start()

func _on_shoot_timer_timeout():
	var elaser = elaser_scene.instantiate()
	enemy.add_child(elaser)
