extends Node2D

var inventory_size=20
var inventory: Array[Item] = []
const slot = preload("res://Assets/UI/InvSlot.tscn")
const preview_ref = preload("res://Assets/UI/inv_preview.tscn")
signal update_inventory
var first_slot:InvSlot
var preview:TextureRect
var your_chest:Array[Item]=[]
var sibling_chest:Array[Item]=[]

var incenses = ['thyme','rosemary','chamomile','feverfew','poppy','sage','peppermint']
var flavors = ['thyme','sage','rosemary','dandelion','poppy','chamomile', 'carp', 'trout','bluegill','wolfberry','raspberry','mushroom', 'egg', 'apple','cheese','turnip','carrot','bread','peppermint']

func _ready():
	inventory.resize(inventory_size)
	your_chest.resize(20)
	sibling_chest.resize(20)
	Signals.inv_slot_clicked.connect(inv_slot_clicked)
	Signals.inv_slot_right_clicked.connect(inv_slot_right_clicked)
	var wood = Item.new()
	wood.set_item('wood',5)
	inventory[0]=wood
	var trout=Item.new()
	trout.set_item('trout',1)
	inventory[1]=trout
	
func add_inv_item(item:Item,inv:Array[Item]):
	for x in inv.size()-1:	
		if inv[x]!=null and inv[x].data_name==item.data_name and item.data.stackable:
			inv[x].quantity+=item.quantity
			update_inventory.emit()
			MainMenu.set_notification("Obtained "+item.data.name+" x"+str(item.quantity))
			return true
	for x in inv.size()-1:
		if inv[x] == null:
			inv[x]=item
			update_inventory.emit()
			MainMenu.set_notification("Obtained "+item.data.name+" x"+str(item.quantity))
			return true
	return false
	
func remove_item(index:int, amount:int, inv:Array[Item]):
	if inv[index]!=null:
		if inv[index].quantity-amount < 0: return false
		if inv[index].quantity-amount==0:
			inv[index]=null
			update_inventory.emit()
			return true
		inv[index].quantity-=amount
		update_inventory.emit()
		return true
	else: return false
		

func inv_slot_clicked(slot:InvSlot):
	#create preview if none
	if preview==null and slot.item!=null:
		create_preview(slot)
	#preview, click on empty slot
	elif preview!=null and slot.item==null:
		print('t')
		slot.inventory[slot.slot_index]=preview.item
		update_inventory.emit()
		preview.queue_free()
	#preview click on occupied slot
	elif preview!=null and slot.item!=null:
		#stackable
		if preview.item.data_name==slot.item.data_name:
			slot.item.quantity+=preview.item.quantity
			update_inventory.emit()
			preview.queue_free()
		else:
			#not stackable
			var temp = preview.item.duplicate()
			create_preview(slot)
			slot.inventory[slot.slot_index]=temp
			preview.queue_free()
			
			update_inventory.emit()			
		
func inv_slot_right_clicked(s:InvSlot):
	if s.item.data.stackable:
		first_slot=s
		var slotq=s.item.quantity/2
		var previewq=s.item.quantity/2+s.item.quantity%2
		first_slot.item.quantity=slotq
		var preview_item = Item.new()
		preview_item.set_item(first_slot.item.data_name,previewq)
		create_preview(preview_item)
		

func create_preview(i:InvSlot):
	var p = preview_ref.instantiate()
	add_child(p)
	p.create_preview(i.item)
	preview=p
	i.inventory[i.slot_index]=null
	first_slot=i
	update_inventory.emit()
	

func _physics_process(delta: float) -> void:
	if preview!=null:
		preview.global_position=get_global_mouse_position()
