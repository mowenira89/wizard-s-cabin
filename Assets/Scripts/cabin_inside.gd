extends Node2D

var player_chest_in_range:bool=false
var sibling_chest_in_range:bool=false
var fire_in_range:bool=false
var hearth_in_range:bool=false
@onready var fire: AnimatedSprite2D = $Fire
@onready var margin_container: MarginContainer = $CanvasLayer/UI/MarginContainer
@onready var UI: NinePatchRect = $CanvasLayer/UI



func _ready():
	fire.play()
	Signals.set_cabin_UI.connect(set_UI)

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
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://Assets/Scenes/backyard.tscn")

func set_UI(u:String):
	for x in margin_container.get_children():
		x.queue_free()
	var a = load(u).instantiate()
	margin_container.add_child(a)


func _input(event:InputEvent):
	if GameStateMachine.current_state is NormalState or GameStateMachine.current_state is HearthState:
		if hearth_in_range:
			if event.is_action_pressed("f"):
				open_hearth()
					
func open_hearth():
	UI.visible=!UI.visible
	set_UI("res://Assets/UI/hearth_menu.tscn")
	if UI.visible:
		GameStateMachine.switch_state("hearth")
	else:
		GameStateMachine.switch_state('normal')


func _on_button_pressed() -> void:
	if margin_container.get_child(0) is FireMenu:
		set_UI("res://Assets/UI/hearth_menu.tscn")
	else: 
		UI.visible=false
		GameStateMachine.switch_state("normal")
		


var creak_in_range:bool=false

func _on_squeak_body_entered(body: Node2D) -> void:
	MainMenu.set_notification("creak")
	creak_in_range=true	

func _on_squeak_body_exited(body: Node2D) -> void:
	creak_in_range=false


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print('a')
