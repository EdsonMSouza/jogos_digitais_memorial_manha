extends KinematicBody2D

var speed = 5

func _physics_process(delta):
	var move = Vector2();
	if Input.get_action_strength("ui_left"):
		move.x -= 1

	if Input.get_action_strength("ui_right"):
		move.x += 1
	
	if Input.get_action_strength("ui_down"):
		move.y += 1
	
	if Input.get_action_strength("ui_up"):
		move.y -= 1
		
	move = move.normalized() * speed
	move = move_and_collide(move)
