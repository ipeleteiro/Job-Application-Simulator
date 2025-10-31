extends SubViewport

@onready var camera: Camera2D = $Camera2D
@onready var minimap: Node2D = $Minimap
@onready var tile: Sprite2D = $Tile


func _process(_delta: float) -> void:
	var floor_tiles: TileMapLayer = OfficeMinimapGlobal.cave_tiles.get_child(0)
	var map_tiles: TileMapLayer = minimap.get_child(1)
	var player_tile_coords = floor_tiles.local_to_map(floor_tiles.to_local(OfficeMinimapGlobal.player.position))
	
	player_tile_coords += Vector2i(12,12)
	
	var local_position = map_tiles.map_to_local(player_tile_coords)
	var tile_size = map_tiles.tile_set.tile_size
	local_position += tile_size / 2.0
	
	camera.position = local_position
	tile.position = local_position + Vector2()
