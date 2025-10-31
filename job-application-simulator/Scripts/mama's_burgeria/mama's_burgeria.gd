extends Panel

signal mama_results(name, result)
@onready var result: RichTextLabel = $Result
@onready var progress: RichTextLabel = $Progress
@onready var path_follow: PathFollow2D = $Path2D/PathFollow
@onready var top_patty: Panel = $Path2D/PathFollow/BottomPatty
@onready var bottom_patty: Panel = $Path2D/PathFollow/TopPatty
var patty_rating = []
var patty_stage = ""
var patty_on_grill = false
var flip_burger = false
var passed = false
var end_game = false

func _ready() -> void:
	reset_burgers()
	bottom_patty.visible = false
	top_patty.visible = false

func reset_burgers():
	patty_stage = "raw"
	
	var cur_style_box : StyleBoxFlat = bottom_patty.get_theme_stylebox("panel")
	cur_style_box.bg_color = Color.hex(0xf4895fff)
	bottom_patty.add_theme_stylebox_override("panel",cur_style_box)
	
	cur_style_box = top_patty.get_theme_stylebox("panel")
	cur_style_box.bg_color = Color.hex(0xf4895fff)
	top_patty.add_theme_stylebox_override("panel",cur_style_box)


func _process(_delta: float) -> void:
	progress.text = str(patty_rating.size()) + "/5"
	# if spacebar is pressed
	if Input.is_action_just_pressed("ui_select"):
		if end_game:
			queue_free()
			mama_results.emit("Mama's Burgeria", passed)
		if patty_rating.size() == 5:
			final_result()
		
		if patty_stage == "raw":
			print("put on grill")
			result.visible = false
			patty_on_grill = true
			bottom_patty.visible = true
			top_patty.visible = true
			patty_stage = "half cooked"
		elif patty_stage == "half cooked" and patty_on_grill:
			print("ready to flip")
			flip_burger = true
			patty_on_grill = false
			patty_stage = "cooked"
		elif patty_on_grill:
			patty_on_grill = false
			result.visible = true
			result.text = calculate_patty_avg()
			if patty_rating.size() == 5:
				result.text += "\nPress SPACE to get results"
			else:
				reset_burgers()
			
	
	if flip_burger and path_follow.progress_ratio < 0.99:
		print("flipping")
		if path_follow.progress_ratio > 0.45:
			# flip burger patty
			pass
		path_follow.progress_ratio += 0.01
	elif flip_burger:
		path_follow.progress_ratio = 0
		flip_burger = false
		patty_on_grill = true
	
	if patty_on_grill and patty_stage == "half cooked":
		print("cooking bottom patty")
		var cur_style_box : StyleBoxFlat = bottom_patty.get_theme_stylebox("panel")
		cur_style_box.bg_color.v -= 0.008
		bottom_patty.add_theme_stylebox_override("panel",cur_style_box)
	elif patty_on_grill and patty_stage == "cooked":
		print("cooking top patty")
		var cur_style_box : StyleBoxFlat = top_patty.get_theme_stylebox("panel")
		cur_style_box.bg_color.v -= 0.01
		top_patty.add_theme_stylebox_override("panel",cur_style_box)

func calculate_patty_avg():
	var cur_style_box : StyleBoxFlat = bottom_patty.get_theme_stylebox("panel")
	print("patty1: " + str(cur_style_box.bg_color.v))
	var rating1 = abs(0.4 - cur_style_box.bg_color.v)
	cur_style_box = top_patty.get_theme_stylebox("panel")
	var rating2 = abs(0.4 - cur_style_box.bg_color.v)
	print("patty2: " + str(cur_style_box.bg_color.v))
	var avg_rating = ((rating1 + rating2) / 2) * 100
	
	patty_rating.append(avg_rating)
	
	print(avg_rating)
	if avg_rating < 5:
		return "Perfect!"
	elif avg_rating < 15:
		return "Good!"
	elif avg_rating < 30:
		return "meh"
	else:
		return "ew. would you eat that??"

func final_result():
	var score = (patty_rating[0] + patty_rating[1] + patty_rating[2] + patty_rating[3] + patty_rating[4]) / 5
	result.text = "Overall you did"
	
	if score < 5:
		passed = true
		result.text += " perfect!"
	elif score < 15:
		passed = true
		result.text += " good!"
	elif score < 30:
		result.text += " meh."
	else:
		result.text += "..... I'm reporting you to food safety."
	
	result.text += "\nPress SPACE to exit."
	end_game = true
