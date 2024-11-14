class_name InvSlot extends TextureRect

@onready var icon: TextureRect = $TextureRect
@onready var quantity: Label = $TextureRect/Label
var inventory:Array[Item]

var item:Item
var disabled:bool=false

func set_item(i:Item, inv:Array[Item]):
	item=i
	inventory = inv
	if i!=null:
		icon.texture=load("res://Assets/Art/Items/"+item.data_name+".png")
		quantity.text = str(item.quantity)

func enable():
	disabled=false

func disable():
	disabled=true

func _on_gui_input(event: InputEvent) -> void:
	if !disabled:
		if event is InputEventMouseButton and event.is_released():
			if event.button_index==1:
				Signals.inv_slot_clicked.emit(self)
			if event.button_index==2:
				Signals.inv_slot_right_clicked.emit(self)
