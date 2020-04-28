extends Node2D


func _ready():
	# verificar se um usuário já existe localmente
	if Login.load_login() != null:
		# carrega os dados
		var user_data = Login.load_login()
		
		# atribuir os dados para as variáveis globais
		Global.user_id = user_data['id']
		Global.user_name = user_data['name']
		Global.user_user = user_data['user']
		
		# chamar o menu do jogo
		get_tree().change_scene("res://scenes/painel_jogo.tscn")
	else:
		# chama a tela de login
		get_tree().change_scene("res://scenes/login.tscn")
