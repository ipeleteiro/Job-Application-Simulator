extends Node2D

var enemy = preload("uid://coily36hnnvtm")
var timer = 0
var spawned = false
var num_enemies_spwaned = 0

func _process(delta: float) -> void:
	timer += delta
	
	if timer > 0.5 and not spawned:
		num_enemies_spwaned += 1
		spawn()
	elif timer > 15:
		timer = 0
		spawned = false

func spawn():
	var enemy_instance = enemy.instantiate()
	enemy_instance.name = "Enemy" + str(num_enemies_spwaned)
	add_child(enemy_instance)
	enemy_instance.global_position = global_position 
	spawned = true
	
