extends Node2D

# mapear um quadrado
const N = 1
const E = 2
const S = 4
const W = 8

export var caminho = Vector2()

# declarar as paredes
var cell_walls = {
		Vector2( 0, -1): N,
		Vector2( 1,  0): E,
		Vector2( 0,  1): S,
		Vector2(-1,  0): W
	}

var tile_size = 64
var width = 20
var height = 12

var cont = 0
var status = false
onready var Map = $TileMap # referencia do tile (mapa)
onready var pl = $Area2D

func _ready():
	randomize()
	tile_size = Map.cell_size
	monta_labirinto()

func check_neighbords(cell, unvisited):
	# retorna um array com as células vizinhas não visitadas
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited:
			list.append(cell + n)
	return list
	
func monta_labirinto():
	var unvisited = [] # controla os nós não visitados
	var stack = [] # pilha
		
	Map.clear() # limpa todas as regiões adjacentes
	
	# preencher com os blocos
	for x in range(width):
		for y in range(height):
			unvisited.append(Vector2(x, y))
			Map.set_cellv(Vector2(x, y), N|E|S|W)
	var current = Vector2(0,0)
	unvisited.erase(current)

	# execução recursiva para o preenchimento do caminho
	while unvisited:
		cont+= 1
		var neighbors = check_neighbords(current, unvisited)
		if neighbors.size() > 0:
			var next = neighbors[randi() % neighbors.size()]
			stack.append(current)
			
			# remover as paredes que foram colocadas indevidamente
			var dir = next - current
			var current_walls = Map.get_cellv(current) - cell_walls[dir]
			var next_walls = Map.get_cellv(next) - cell_walls[-dir]
			Map.set_cellv(current, current_walls)
			Map.set_cellv(next, next_walls)
			current = next
			unvisited.erase(current)
			
		elif stack:
			current = stack.pop_back()
		
		# Mostra a montagem em tempo real (demora mais)
		#yield(get_tree(), 'idle_frame')
		
		get_node("player").set_global_position(Vector2(32, 32))
		
	var plPos = Map.get_used_cells_by_id(13)[-1]
	pl.global_position = Map.map_to_world(plPos) + Vector2(32,32)

func _on_Area2D_body_entered(body):
	print("Tocou")
