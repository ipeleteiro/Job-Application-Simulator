extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var cave_tiles: Node2D = $Cave
@onready var map_tiles: Node2D = $CanvasLayer/SubViewportContainer/SubViewport/Minimap


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OfficeMinimapGlobal.player = player
	OfficeMinimapGlobal.cave_tiles = cave_tiles
	OfficeMinimapGlobal.map_tiles = map_tiles


func _process(_delta: float) -> void:
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	OfficeMinimapGlobal.minimap_discovery(player)
