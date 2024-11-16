class_name Pickup extends Sprite2D

var item:Item
var in_range:bool=false
var forage_node=null

func set_item(i:Item):
	item=i
	texture=load("res://Assets/Art/Items/"+item.data_name+".png")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range=true
		var instruction = "Press F to collect "+item.data.name
		Signals.send_instruction.emit(instruction)

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		in_range=false
		Signals.send_instruction.emit("")
		
func _input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("f"):
			if InvManager.add_inv_item(item,InvManager.inventory):
				if forage_node!=null: forage_node.set_timer()
				Signals.pickup_picked_up.emit()
				queue_free()
