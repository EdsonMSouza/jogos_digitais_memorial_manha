extends KinematicBody2D

var motion = Vector2()
const UP = Vector2(0, -1)
const SPEED = 192
const GRAVITY = 20
#const JUMP_FORCE = -700

onready var sprite = preload("res://Sprite.tscn")

func _ready():
	#for i in range(10):
	#	var s = sprite.instance()
	#	add_child(s)
	pass
	
func _physics_process(delta):
	# Algoritmo para controle da movimentação
	#motion.y += GRAVITY
	if Input.is_action_pressed('ui_right'):
		motion.x = SPEED
	elif Input.is_action_pressed('ui_left'):
		motion.x = -SPEED
	elif Input.is_action_pressed('ui_up'):
		motion.y = -SPEED
	elif Input.is_action_pressed('ui_down'):
		motion.y = SPEED
	else:
		motion.x = 0
		motion.y = 0
		
	# Verifica se o personagem está no chão
	#if is_on_floor():
		
		# Verifica se atecla pressionada foi o ESPAÇO (Configurada em Project->Project Settings)
		#if Input.is_action_just_pressed("jump"):
		#	motion.y = JUMP_FORCE
			
	motion = move_and_slide(motion)
