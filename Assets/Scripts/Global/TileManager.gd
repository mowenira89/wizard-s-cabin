extends Node

var tilemap:TileMap
const grass = preload("res://Assets/Scenes/grass.tscn")
var grass_save_dict = {}

func set_tilemap(t:TileMap):
	tilemap=t
	grassify()

func grassify():
	var grass_tiles = tilemap.get_used_cells_by_id(1,2,Vector2(0,0))
	for t in grass_tiles:
		tilemap.set_cell(1,t,-1,Vector2(-1,-1))
		var g = grass.instantiate()
		tilemap.add_child(g)
		g.global_position=tilemap.map_to_local(t)
		
