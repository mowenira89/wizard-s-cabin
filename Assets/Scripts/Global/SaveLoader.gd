extends Node

func _ready():
#	load_game(0)
	pass
	
var save_data = {
	'player_data':PlayerManager.data,
	'sibling_data':SisterManager.sibling,
	'player_inv':InvManager.inventory,
	'player_chest':InvManager.your_chest,
	'sibling_chest':InvManager.sibling_chest
}

func get_save_file_path(slot: int) -> String:
	return "user://save_slot_%d.json" % slot
	
func save_game(slot: int) -> void:
	save_data["scene_path"]=get_tree().current_scene.get_path()
	save_data['player_pos']=PlayerManager.player.global_position
		
	
	var file = FileAccess.open(get_save_file_path(slot), FileAccess.WRITE)
	file.store_var(save_data,true)
	file.close()
	
func load_game(slot:int):
	if FileAccess.file_exists(get_save_file_path(slot)):
		var file = FileAccess.open(get_save_file_path(slot),FileAccess.READ)
		save_data=file.get_var(true)
		if get_tree().change_scene_to_file(save_data['scene_path'])==ERR_CANT_CREATE:
			print('failed')
		else:
			PlayerManager.player.position=save_data['player_pos']
			PlayerManager.data=save_data['player_data']
			SisterManager.sibling=save_data['sibling_data']
			InvManager.inventory=save_data['player_inv']
			InvManager.your_chest=save_data['player_chest']
			InvManager.sibling_chest=save_data['sibling_chest']
		file.close()
			
		
