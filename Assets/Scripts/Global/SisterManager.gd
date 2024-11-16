extends Node

var sibling:Sibling

func _ready():
	if sibling==null: set_sibling()
	
func set_sibling():
	sibling=load("res://Assets/Resources/Entities/sibling.tres").duplicate()
	sibling.set_sibling()
