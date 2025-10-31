extends CharacterBody2D

@onready var light: PointLight2D = $Light
@onready var sprite: AnimatedSprite2D = $sprite
@onready var collision: CollisionShape2D = $CollisionShape2D
var dead = false
@onready var na: NavigationAgent2D = $NavigationAgent2D

const SPEED = 50.0
var player: CharacterBody2D
var hits = 0

func _ready() -> void:
	light.energy = 0
	hits = 0
	player = OfficeMinimapGlobal.player

func _physics_process(delta: float) -> void:
	
	if hits > 2:
		dead = true
	if dead:
		collision.disabled = true
		sprite.play("dead")
		light.energy = 0
		return
	
	na.target_position = player.global_position
	var next = na.get_next_path_position()
	var direction = global_position.direction_to(next)
	var distance_to_player = (player.global_position - global_position).length()
	
	
	if is_hit_back and hit_back_timer < 0.5:
		hit_back_timer += delta
		velocity += direction * 2
	elif is_hit_back:
		is_hit_back = false
	else:
		velocity = direction * SPEED
	
		# velocity
		if distance_to_player < 100:
			velocity *= distance_to_player * 0.05
		
	# light
	if distance_to_player < 50:
		OfficeMinimapGlobal.minimap_discovery(self)
		if light.energy < 1:
			light.energy += 0.01
	else:
		if light.energy > 0:
			light.energy -= 0.01
	
	move_and_slide()

var is_hit_back = false
var hit_back_timer = 0

func hit_back():
	var next = na.get_next_path_position()
	var direction = global_position.direction_to(next)
	velocity = -direction * 150
	
	is_hit_back = true
	hit_back_timer = 0
