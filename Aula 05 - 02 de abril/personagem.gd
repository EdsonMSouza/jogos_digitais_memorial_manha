extends KinematicBody2D

export(int) var speed = 200
var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

	return velocity

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

# quando ENTRAR na área de colisão
func _on_Area2D_body_entered(body):
	# Faz a troca da cena
	get_tree().change_scene("res://cena_2.tscn")

# quando SAIR da área de colisão
func _on_Area2D_body_exited(body):
	print("Saiu da colisão")
