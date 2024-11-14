class_name InvScreen extends Control

const slot = preload("res://Assets/UI/InvSlot.tscn")
@onready var inv_container: GridContainer = $InvContainer


func _ready():
	for s in InvManager.inventory:
		var _slot = slot.instantiate()
		inv_container.add_child(_slot)
		if s != null:
			_slot.set_item(s)
