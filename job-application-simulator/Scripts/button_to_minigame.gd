extends Button

signal make_new_tab(link_to_minigame_scene, company, emailID)
var image: Texture2D
var link_to_minigame_scene: String
var company: String
var emailID: String


func _on_pressed() -> void:
	make_new_tab.emit(link_to_minigame_scene, company, emailID)
