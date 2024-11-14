extends VBoxContainer



func _on_save_pressed() -> void:
	SaveLoader.save_game(0)


func _on_load_pressed() -> void:
	SaveLoader.load_game(0)
