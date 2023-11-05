extends Area2D

@export var speed = 700
var explosion_scene = preload("res://scenes/explosion.tscn")
func _physics_process(delta):
	global_position.y += -speed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():  #have laser despawn on top of screen
	queue_free()

func _on_area_entered(area):
	if area is Enemy:
		area.die()
		die()

func die():
	queue_free()
	var effect = explosion_scene.instantiate()
	effect.global_position = global_position
	get_tree().current_scene.add_child(effect)


