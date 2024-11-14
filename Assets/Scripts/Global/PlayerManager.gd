extends Node

var player:Player
var movement_speed:int=200
var data:Entity

func _ready():
	data=load("res://Assets/Resources/Entities/player.tres").duplicate()
	Signals.set_player_bars.emit()

func player_ref(p:Player):
	player = p

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("LControl") and event.is_pressed():movement_speed=300
	if event.is_action("LControl") and event.is_released():
		movement_speed=200
	
