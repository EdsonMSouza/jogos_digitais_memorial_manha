extends KinematicBody2D

var player = null
var move = Vector2.ZERO
var speed = 2

func _physics_process(delta):
	move = Vector2.ZERO
	
	if (player != null):
		# move o objeto em direção ao centro do outro
		move = position.direction_to(player.position) * speed
	else:
		move = Vector2.ZERO

	move = move.normalized() * speed
	move = move_and_collide(move)


func _on_Area2D_body_entered(body):
	if (body != self):
		player = body


func _on_Area2D_body_exited(body):
	player = null

func _on_Area2D2_area_entered(area):
	print("Te peguei!!!")
