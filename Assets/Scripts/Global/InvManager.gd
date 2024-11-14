extends Node2D

var inventory_size=20
var inventory: Array[Item] = []
const slot = preload("res://Assets/UI/InvSlot.tscn")
signal update_inventory
var first_slot:InvSlot
var preview:TextureRect

var incenses = ['thyme','rosemary','chamomile','feverfew','poppy']
var flavors = ['thyme','sage','rosemary','dandelion','poppy','chamomile', 'carp', 'trout','bluegill','wolfberry','raspberry','mushroom', 'egg', 'apple','cheese']

func _ready():
	inventory.resize(inventory_size)
	Signals.inv_slot_clicked.connect(inv_slot_clicked)
	
func add_inv_item(item:Item):
	for x in inventory_size:	
		if inventory[x]!=null and inventory[x].data_name==item.data_name:
			inventory[x].quantity+=item.quantity
			update_inventory.emit()
			return true
	for x in inventory_size:
		if inventory[x] == null:
			inventory[x]=item
			update_inventory.emit()
			return true
	return false
	
func remove_item(index:int, amount:int):
	if inventory[index]!=null:
		if inventory[index].quantity-amount < 0: return false
		if inventory[index].quantity-amount==0:
			inventory[index]=null
			return true
		inventory[index].quantity-=amount
		return true
	else: return false
		

func inv_slot_clicked(slot:InvSlot):
	if first_slot==null:
		first_slot=slot
		first_slot.icon.visible=false
		preview=create_preview(first_slot)
	else:
		
		if slot.item!=null and first_slot.item.data_name==slot.item.data_name:
			first_slot.item.quantity+=slot.item.quantity
			preview.queue_free()
			update_inventory.emit()
		else:
			var temp = slot.item
			var first_index = first_slot.get_parent().get_children().find(first_slot)
			var second_index = slot.get_parent().get_children().find(slot)
			slot.inventory[second_index] = first_slot.item
			first_slot.inventory[first_index]=temp
			update_inventory.emit()
			preview.queue_free()
			slot.icon.visible=false
			preview = create_preview(slot)
			
func create_preview(slot:InvSlot):
	var t = TextureRect.new()
	get_tree().root.add_child(t)
	t.texture = slot.icon.texture
	t.mouse_filter=Control.MOUSE_FILTER_IGNORE
	t.z_index=2
	return t

func _physics_process(delta: float) -> void:
	if preview!=null:
		preview.global_position=get_global_mouse_position()
