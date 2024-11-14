extends Node2D

var player_chest_in_range:bool=false
var sibling_chest_in_range:bool=false
var fire_in_range:bool=false
var hearth_in_range:bool=false

func _on_fire_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print('player damaged')




func _on_chest_player_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Signals.send_instruction.emit("Press F to open your chest")
		player_chest_in_range=true

func _on_chest_player_body_exited(body: Node2D) -> void:
	Signals.send_instruction.emit("")
	player_chest_in_range=false


func _on_chest_sibling_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Signals.send_instruction.emit("Press F to open your sibling's chest")
		sibling_chest_in_range=true

func _on_chest_sibling_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Signals.send_instruction.emit("")
		sibling_chest_in_range=false


func _on_cauldron_interact_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Signals.send_instruction.emit("Press F to interact with Hearth")
		hearth_in_range=true


func _on_cauldron_interact_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Signals.send_instruction.emit("")
		hearth_in_range=false


func _on_exit_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
