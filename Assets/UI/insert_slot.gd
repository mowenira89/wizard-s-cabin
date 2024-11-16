class_name Inserter extends VBoxContainer

@onready var slot: InvSlot = $InvSlot

func _ready():
	slot.disabled=true

func _on_texture_button_pressed() -> void:
	if InvManager.remove_item(slot.slot_index,1,slot.inventory):
		CabinManager.change_fire(slot.item.data.burn_time)
		slot.set_item(slot.item,slot.inventory)
		MainMenu.disable_hotbar()
		Signals.reset_fire_menu.emit()
