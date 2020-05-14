extends KinematicBody2D

export(int) var speed = 200

var contador = 0
var velocity = Vector2()

func alert(text: String, title: String='Message') -> void:
	var dialog = $gameover #Controle AcceptDialog
	dialog.rect_min_size = Vector2(250,150)
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_close', dialog, 'queue_free')
	dialog.get_ok()
	add_child(dialog)
	dialog.popup_centered()

	
# verifica a steclas acionadas
func get_input():
	# pega as coordenadas atuais
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

# realiza o processamento do comportamento físico da interface
func _physics_process(delta):
	get_input()
	# move_and_slide() desloca para a posição informada via teclado
	# e guarda a nova posição (x,y)
	velocity = move_and_slide(velocity)

# verifica a colisão dos objetos
func _on_Area2D_body_entered(body):
	contador += 1
	
	# Segue uma condição para finalizar (Ganhou ou Morreu)
	if(contador > 2):
		# remove a Sprite do ambiente
		# Deve também remover o StaticBody
				
		alert(Global.user_name + ", " + "você morreu\n\nO 'score' do jogo foi salvo via API", "Aviso")

		var data_to_send = {
			"type":"save",
			"game_id":Global.game_id,
			"score":350
			}		
		var var_post = JSON.print(data_to_send)
		var header = ["Content-Type: application/json"]
		var url = "http://apijogosdigitais.atwebpages.com/api/game.php"
		var use_ssl = false
		$HTTPRequest.request(url, header, use_ssl, HTTPClient.METHOD_POST, var_post)
		
	$placar.set_text(str(contador))

# resposta da requisição da API
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	#alert(Global.user_name + ", " + "você morreu\n\nO 'score' do jogo foi salvo via API", "Aviso")
	#alert(Global.user_name + " você morreu/ganhou.", json.result['value'])

# carrega o Painel do Jogo
func _on_gameover_confirmed():
	get_tree().change_scene("res://scenes/painel_jogo.tscn")
