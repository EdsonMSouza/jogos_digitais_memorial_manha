extends Node2D

func alert(text: String, title: String='Message') -> void:
	var dialog = AcceptDialog.new()
	dialog.rect_min_size = Vector2(250,150)
	dialog.dialog_text = text
	dialog.window_title = title
	dialog.connect('modal_closed', dialog, 'queue_free')
	add_child(dialog)
	dialog.popup_centered()

	
func _ready():
	# mostra o nome do usuário logado
	$user_name.set_text("User: " + Global.user_name)
	
# Carega o ranking geral
func _on_ranking_geral_pressed():
	# carrega o Ranking Geral
	get_tree().change_scene("res://scenes/placar_geral.tscn")

# carrega o ranking do usuário
func _on_ranking_usuario_pressed():
	get_tree().change_scene("res://scenes/placar_usuario.tscn")
	
	
# cria um novo jogo
func _on_novo_jogo_pressed():
	# monta o json para enviar para a API e criar um novo jogo
	var data_to_send = {
		"type":"new",
		"user_id":Global.user_id
	}

	var var_post = JSON.print(data_to_send)
	var header = ["Content-Type: application/json"]
	var url = "http://apijogosdigitais.atwebpages.com/api/game.php"
	var use_ssl = false
	$HTTPRequest.request(url, header, use_ssl, HTTPClient.METHOD_POST, var_post)
	
# recebe a requisição enviada
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	# pega os dados retornados pela API
	var json = JSON.parse(body.get_string_from_utf8())

	if(json.result["data"] == "game_created"):
		# salva o ID do game criado na variável Global
		Global.game_id = json.result['value']
		get_tree().change_scene("res://scenes/fase_1.tscn")
	else:
		alert("Erro a criar o jogo.\n\nErro:" + json.result["value"], "Atenção")
		
# sai do jogo (fecha tudo)
func _on_sair_pressed():
	get_tree().quit()

# faz o logout
func _on_logout_pressed():
	Login.logout()
	get_tree().change_scene("res://scenes/login.tscn")

