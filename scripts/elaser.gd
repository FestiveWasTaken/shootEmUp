extends Area2D

@export var speed = 200

func _physics_process(delta):
	global_position.y += speed * delta 

func _on_visible_on_screen_notifier_2d_screen_exited():  #have laser despawn on top of screen
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		queue_free()
