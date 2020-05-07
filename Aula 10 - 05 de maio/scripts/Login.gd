extends Node2D

# arquivo com os dados do usuário
const USER_DATA = "user_data.json"

# função para carregar os dados gravados localmente
static func load_login():
	# cria um objeto para manipular arquivos
	var file = File.new()
	# verifica se existe o arquivo
	if not file.file_exists(USER_DATA):
		print("Arquivo não existe - Não tem login")
		return
	
	# tentar abrir o arquivo
	if file.open(USER_DATA, File.READ) != 0:
		print("Erro ao abrir o arquivo")
		return
		
	# se deu tudo certo, então carrega os dados
	var data = parse_json(file.get_line())
	
	return data	
	
# função para salvar os dados localmente
static func save_login(var_id, var_name, var_user):
	var file = File.new()			
	if file.open(USER_DATA, File.WRITE) != 0:
		print("Erro ao abrir o arquivo")
		return
	
	# monta o json para salvar no arquivo
	var data = {
		id = var_id,
		name = var_name,
		user = var_user
	}

	# grava os dados
	file.store_line(to_json(data))
	
	# fecha o arquivo
	file.close()
	
# função para carregar os dados gravados localmente
static func logout():
	# verifica se existe o arquivo
	var dir = Directory.new()
	var err = dir.remove(USER_DATA)
	
