extends CanvasLayer

const inv_screen = preload("res://Assets/UI/InvScreen.tscn")
const game_screen = preload("res://Assets/UI/game_menu.tscn")
const notification = preload("res://Assets/UI/notification.tscn")
@onready var hotbar: HBoxContainer = $VBox/Hotbar
@onready var interaction_container: HBoxContainer = $InteractionContainer
@onready var instruction_panel: ColorRect = $InteractionContainer/Panel
@onready var instruction_label: Label = $InteractionContainer/Panel/Label
@onready var player_stats: Control = $PlayerStats
@onready var main_display: MarginContainer = $MainMenu/NinePatchRect/MarginContainer
@onready var main_menu: VBoxContainer = $MainMenu
@onready var notification_window: VBoxContainer = $VBox/HBoxContainer/NotificationWindow

var equipped:InvSlot
var equipped_index:int=0

func _ready():
	set_hotbar()
	InvManager.update_inventory.connect(set_hotbar)
	Signals.send_instruction.connect(set_instruction)
	player_stats.set_bars()

func set_hotbar():
	for x in hotbar.get_children():
		x.queue_free()
	for x in range(0,10):
		var slot = InvManager.slot.instantiate()
		hotbar.add_child(slot)
		if InvManager.inventory[x]!=null:
			slot.set_item(InvManager.inventory[x], InvManager.inventory)
		else: slot.set_item(null, InvManager.inventory)

func set_instruction(s:String):
	if s=="":
		instruction_panel.visible=false
		return 	
	instruction_label.text=s
	instruction_panel.visible=true

func set_notification(s:String):
	var note = notification.instantiate()
	notification_window.add_child(note)
	note.set_note(s)

func set_bars():
	player_stats.set_bars()

func clear_main_screen():
	for x in main_display.get_children():
		x.queue_free()

func disable_hotbar():
	for x in hotbar.get_children():
		x.disable()

func enable_hotbar():
	for x in hotbar.get_children():
		x.enable()

func close_main_menu():
	main_menu.visible=false
	
func open_main_menu():
	main_menu.visible=true

func _on_game_pressed() -> void:
	clear_main_screen()
	var gamescreen = game_screen.instantiate()
	main_display.add_child(gamescreen)

func _on_inventory_pressed() -> void:
	clear_main_screen()
	var invscreen = inv_screen.instantiate()
	main_display.add_child(invscreen)	

func change_equipped(d:int):
	equipped_index+=d
	if equipped_index<0:equipped_index=9
	if equipped_index>9:equipped_index=0
	equipped=hotbar.get_child(equipped_index)
	change_colors()
	
func change_colors():
	for x in hotbar.get_children():
		x.change_color("yellow")
	hotbar.get_children()[equipped_index].change_color('green')
