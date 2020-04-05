extends Node2D

var timer # variável para controlar o tempo
var seconds :int = 10 # variável para informar o tempo de duração do Timer

# função que é executada quando a cena é carregada
func _ready(): 
	timer = Timer.new() # cria o objeto Timer
	timer.connect("timeout", self, "_on_timer_timeout") # controla o fim do timer
	timer.set_wait_time(1) # tempo de duração do timer = 1seg
	timer.set_one_shot(false) # relógio contínuo
	add_child(timer) # adiciona o objeto timer na árvore de processos
	timer.start() # iniciar o relógio (Timer)

func _physics_process(delta): # função que monitora o processamento do jogo (Física)
	# mostra no label "contador" o valor dos segundos a cada iteração do Timer
	get_node("contador").set_text( str(seconds) )
	
	if(seconds < 1): # lógica para verificar quando o tempo acabou
		timer.stop() # para o tempo
		
		# retorna para a cena anterior
		get_tree().change_scene("res://principal.tscn")
	
# função para realizar algo quando o tempo terminar
func _on_timer_timeout():
	seconds -= 1
