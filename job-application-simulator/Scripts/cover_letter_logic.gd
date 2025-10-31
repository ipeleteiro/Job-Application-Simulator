extends Control

@onready var label: Label = $"Cover Letter/Label2"
var essay := """Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos.

Lorem ipsum dolor sit amet consectetur adipiscing elit. Quisque faucibus ex sapien vitae pellentesque sem placerat. In id cursus mi pretium tellus duis convallis. Tempus leo eu aenean sed diam urna tempor. Pulvinar vivamus fringilla lacus nec metus bibendum egestas. Iaculis massa nisl malesuada lacinia integer nunc posuere. Ut hendrerit semper vel class aptent taciti sociosqu. Ad litora torquent per conubia nostra inceptos himenaeos."""

var index := 0

var reveal_rate := 5
@onready var time: Label = $"Typing UI/Time"
@onready var result: Label = $"Typing UI/Result"

var timer = 0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if index > 0 and timer < 20 and index < essay.length() - 1:
		timer += delta
		time.text = "%.2f" % (20 - timer) + "s"
	
	
	if index == essay.length() - 1 and (20 - timer) >= 0:
		result.text = "SUCESSFUL Cover Letter"
	elif (20 - timer) <= 0 and index <= essay.length():
		result.text = "FAILED Cover Letter"
		
	if Input.is_action_just_pressed("space"):
		_reveal_text()

func _reveal_text():
	if index <= essay.length():
		index += reveal_rate
		label.text = essay.substr(0, index)
