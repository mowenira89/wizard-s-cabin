class_name Woodchopper extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
var in_range:bool=false
@onready var target: Sprite2D = $ColorRect/ColorRect/Target
func _ready():
	anim.play("move")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Axe"):
		in_range=true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Axe"):
		in_range=false
		
func move_target():
	target.position.x=(randi_range(40,380))
