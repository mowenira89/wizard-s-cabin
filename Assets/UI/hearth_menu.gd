class_name HearthMenu extends HBoxContainer


func _on_burn_pressed() -> void:
	Signals.set_cabin_UI.emit("res://Assets/UI/fire_menu.tscn")
	
