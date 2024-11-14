class_name Woodchopper extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
var in_range:bool=false

func _ready():
	anim.play("move")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Axe"):
		in_range=true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Axe"):
		in_range=false
		
