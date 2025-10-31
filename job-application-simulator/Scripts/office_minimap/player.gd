extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite
@onready var bullets: Node2D = $Bullets
@onready var axe: Area2D = $Weapon

const speed = 100.0

func _ready() -> void:
	OfficeMinimapGlobal.player = self
	axe.visible = false

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "away", "towards")
	
	if is_hit_back and hit_back_timer < 0.5:
		hit_back_timer += delta
		velocity += direction * 5
	elif is_hit_back:
		is_hit_back = false
	else:
		velocity = direction * 100
	
	if Input.is_action_pressed("left"):
		sprite.play("left")
	elif Input.is_action_pressed("away"):
		sprite.play("away")
	elif Input.is_action_pressed("right"):
		sprite.play("right")
	elif Input.is_action_pressed("towards"):
		sprite.play("towards")
	else:
		sprite.play("default")
	
	if Input.is_action_pressed("axe") and not is_axe_swinging:
		start_swing_axe()
	
	if is_axe_swinging and swing_timer < 0.2:
		swing_timer += delta
		axe.rotation -= 0.1
	elif is_axe_swinging:
		is_axe_swinging = false
		axe.visible = false
	
	move_and_slide() # ooooooh magiccccc

var is_axe_swinging = false
var swing_timer = 0

func start_swing_axe():
	var direction := Input.get_vector("left", "right", "away", "towards")
	axe.visible = true
	
	var angle = rad_to_deg(Vector2(0,-1).angle_to(direction)) - 180
	
	axe.rotation = angle + 30
	is_axe_swinging = true
	swing_timer = 0

var is_hit_back = false
var hit_back_timer = 0

func hit_back():
	var direction := Input.get_vector("left", "right", "away", "towards")
	velocity = -direction * 150
	
	is_hit_back = true
	hit_back_timer = 0
