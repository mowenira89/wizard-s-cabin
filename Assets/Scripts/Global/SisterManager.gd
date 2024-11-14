extends Node

var sibling:Sibling

func _ready():
	sibling=load("res://Assets/Resources/Entities/sibling.tres")
	sibling.set_sibling()
