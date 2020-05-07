extends Panel

# carregar a cena ListItem que contém o esqueleto da lista
const ListItem = preload("res://scenes/ListItem.tscn")

# controlar a nossa sequência
var listIndex = 0

# função para adicionar elementos em uma lista de forma dinâmica
func addItem(score, user):
	var item = ListItem.instance() # cria uma instância da lista
	listIndex += 1 # incrementa o valor do item da lista
	
	# adicionar de fato o item na lista (para os dois objetos Label)
	item.get_node("posicao").text = str(listIndex)
	item.get_node("sequencia").text = str(score)
	item.get_node("descricao").text = user
	item.rect_min_size = Vector2(320, 30)
	
	# atribuir a lista o ScrollContainer
	$ScrollContainer/list.add_child(item)
	
func _ready():
	var data_to_send = {"type":"ranking_general"}
	var var_post = JSON.print(data_to_send)
	var header = ["Content-Type: application/json"]
	var url = "http://apijogosdigitais.atwebpages.com/api/game.php"
	var use_ssl = false
	$HTTPRequest.request(url, header, use_ssl, HTTPClient.METHOD_POST, var_post)

# resposta da requisição da API
func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	for x in json.result:
		for dados in [x]:			
			addItem(dados['Score'], dados['User'])

# carrega o painel do jogo
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/painel_jogo.tscn")            
