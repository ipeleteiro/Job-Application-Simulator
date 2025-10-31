extends Area2D

var direction: Vector2

func _on_body_entered(body: Node2D) -> void:
	if "Enemy" in body.name:
		if body.dead != true:
			body.hits += 1
			body.hit_back()
			OfficeMinimapGlobal.player.hit_back()
	if "Wall" in body.name:
		OfficeMinimapGlobal.player.hit_back()

func _process(_delta: float) -> void:
	if visible:
		monitoring = true
	else:
		monitoring = false
