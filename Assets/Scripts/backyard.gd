extends Node2D
@onready var tile_map: TileMap = $TileMap
var axe_in_range:bool=false
var chopping_wood:bool=false

@onready var inside = preload("res://Assets/Scenes/CabinInside.tscn") as PackedScene

func _ready():
	TileManager.set_tilemap(tile_map)



func _on_axe_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		MainMenu.set_instruction("Press F to chop wood.")
		axe_in_range=true


func _on_axe_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		MainMenu.set_instruction("")
		axe_in_range=false
		
func _input(event):
	if axe_in_range:
		if event.is_action_pressed("f"):
			GameStateMachine.switch_state("woodchopping")


func _on_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Assets/Scenes/CabinInside.tscn")
