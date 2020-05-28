extends Node2D

onready var sprite = preload("res://Sprite.tscn")
func _ready():
	pass


func _on_Button_pressed():
	for i in range(1):
		var s = sprite.instance()
		add_child(s)
	pass
