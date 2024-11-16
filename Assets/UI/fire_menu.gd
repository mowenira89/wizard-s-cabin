class_name FireMenu extends HBoxContainer

const inserter = preload("res://Assets/UI/insert_slot.tscn")

func _ready():
	set_screen()
	Signals.reset_fire_menu.connect(set_screen)

func set_screen():
	for x in get_children():
		x.queue_free()
	for i in [InvManager.inventory, InvManager.your_chest]:
		for x in i:
			if x is Item:
				if x.data.burnable:
					var n = inserter.instantiate()
					add_child(n)
					n.slot.set_item(x,i)
