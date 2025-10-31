extends Node

var player: CharacterBody2D
var cave_tiles
var map_tiles


func minimap_discovery(character):
	var floor_tiles: TileMapLayer = cave_tiles.get_child(0)
	var cover_tiles: TileMapLayer = map_tiles.get_child(2)
	var char_tile_coords = floor_tiles.local_to_map(floor_tiles.to_local(character.global_position))
	
	var tile_combos = [Vector2i(0,1), Vector2i(1,0), Vector2i(0,-1), Vector2i(-1,0), 
						Vector2i(1,1), Vector2i(-1,1), Vector2i(1,-1), Vector2i(-1,-1)]
	
	for t in tile_combos:
		var cur_tile_coords = char_tile_coords + t
		if floor_tiles.get_cell_atlas_coords(cur_tile_coords) == Vector2i(-1, -1):
			#print("wall")
			pass
		else:
			#print("floor")
			pass
		print("erasing:" + str(cur_tile_coords))
		cover_tiles.erase_cell(cur_tile_coords)
