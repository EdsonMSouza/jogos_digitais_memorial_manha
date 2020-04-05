extends KinematicBody2D


# carrega o player no início da cena
onready var motor = $player

export(int) var speed = 200
var velocity = Vector2()

func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1	
		# verifica se o motor está desligado. Se estiver, liga (.play())
		if(!motor.playing):
			motor.play()
			
	# lógica para parar o montor quando uma tecla é liberada.
	# Se foi liberada, para o motor (.stop())
	if Input.is_action_just_released('ui_right'):	
		motor.stop()
		
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
