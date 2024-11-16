class_name InvSlot extends TextureRect

@onready var name_label: Label = $Label
@onready var icon: TextureRect = $TextureRect
@onready var quantity: Label = $TextureRect/Label
var inventory:Array[Item]
var slot_index:int
var yellow = preload("res://Assets/Art/UI/mainitemslot.png")
var green = preload("res://Assets/Art/UI/invslotgreen.png")

var item:Item
@export var disabled:bool=false

func set_item(i:Item, inv:Array[Item]):
	item=i
	inventory = inv
	slot_index=inventory.find(item)
	if i!=null:
		icon.texture=load("res://Assets/Art/Items/"+item.data_name+".png")
		quantity.text = str(item.quantity)
		name_label.text=item.data.name
		
func enable():
	disabled=false
	modulate = Color("#ffffff")

func disable():
	disabled=true
	modulate = Color("#7f7f7f")

func _on_gui_input(event: InputEvent) -> void:
	if !disabled:
		if event is InputEventMouseButton and event.is_released():
			if event.button_index==1:
				Signals.inv_slot_clicked.emit(self)
			if event.button_index==2:
				Signals.inv_slot_right_clicked.emit(self)

func _on_panel_mouse_entered() -> void:
	name_label.visible=true	

func _on_panel_mouse_exited() -> void:
	name_label.visible=false

func change_color(c:String):
	if c=="yellow":texture=yellow
	if c=="green":texture=green
