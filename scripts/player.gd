class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)

@export var speed = 300

@onready var gun = $Gun

var laser_scene = preload("res://scenes/laser.tscn")

var shootCD := false

func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shootCD:
			shootCD = true 
			shoot()
			await get_tree().create_timer(0.3).timeout #rate of fire
			shootCD = false

func _physics_process(delta):
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
	Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	move_and_slide()

func shoot():
	laser_shot.emit(laser_scene, gun.global_position) #calls the laser scene to spawn from ship
	
func die():
	queue_free()
