extends Node2D



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('Scythe'):
		var i = Item.new()
		i.set_item('grass',1)
		InvManager.add_inv_item(i,InvManager.inventory)
