extends KinematicBody2D

# declaração das variáveis
export (int) var speed = 400
var velocity = Vector2()
var vida = 3

func _ready():
		# coloca o valor da variável vida no placar (label)
	get_parent().get_node("placar").text = "Vidas: " + str(vida)
	
func get_input():
	# captura a posição do mouse na tela
	look_at(get_global_mouse_position())
	
	# captura a posição ATUAL do mouse
	velocity = Vector2()
	
	# captura se foi pressionada tecla seta-abaixo
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
		
	# captura se foi pressionada tecla seta-acima
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)	
	
	return velocity
	
func _physics_process(delta):
	if(Input.is_key_pressed(KEY_LEFT)):
		self.position.x-= 1

	if(Input.is_key_pressed(KEY_RIGHT)):
		self.position.x+= 1 
	
	if(Input.is_key_pressed(KEY_UP)):
		if(Input.is_key_pressed(KEY_SHIFT)):
			self.position.y-= 10
		else:
			self.position.y-= 1
	
	if(Input.is_key_pressed(KEY_DOWN)):
		if(Input.is_key_pressed(KEY_SHIFT)):
			self.position.y+= 10
		else:
			self.position.y+= 1
	
	if(Input.is_key_pressed(KEY_Q)):
		get_tree().quit()
	
	
	# checando a posição do mouse em tempo de execução
	if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		self.position = get_viewport().get_mouse_position()
		

# quando entrar na área do corpo da colição, faz alguma coisa	
func _on_Area2D_body_entered(body):
	# toca o áudio
	$dano.play()
	
	# diminui uma vida
	vida -= 1
	
	# coloca o valor da variável vida no placar (label)
	get_parent().get_node("placar").text = "Vidas: " + str(vida)
	
	# lógica para o cálculo das vidas (se vida menor que zero, reseta)
	if(vida == -1):
		# toca o som da morte
		$morreu.play()
		
		# manipulando a aprição do personagem
		if(get_parent().get_node("personagem").is_visible()):
			# esconde o pesrsonagem
			get_parent().get_node("personagem").hide()
		# aciona a execução do Timer por 2 segundos
		get_parent().get_node("personagem/Timer").start()
	
# após finalizar a execução do áudio
func _on_morreu_finished():
	get_parent().get_node("personagem/Timer").start()

# quando o tempo acabar (2 seg.)
func _on_Timer_timeout():
	# mostra o personagem novamente
	get_parent().get_node("personagem").show()
	
	# recarrega a cena como no início do jogo
	get_tree().reload_current_scene()









