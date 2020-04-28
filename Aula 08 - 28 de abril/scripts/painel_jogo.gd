extends Node2D

func _ready():
	# mostra o nome do usuário logado
	$user_name.set_text("Olá: " + Global.user_name)
