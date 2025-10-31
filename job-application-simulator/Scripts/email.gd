extends Control

signal email_opened(company, emailID)

var company: String = "Helpful Advice"
var emailID: String = "0"
var status: String
var has_been_opened: bool
@onready var email_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		email_sprite.play("selected")
		has_been_opened = true
		emit_signal("email_opened", company, emailID)
	else:
		if not has_been_opened:
			email_sprite.play("unopened")
		else:
			email_sprite.play("opened")

func set_sender(s):
	var sender = self.get_children()[1].get_children()[0]
	sender.text = s
	

func set_title(t):
	var title = self.get_children()[1].get_children()[1]
	title.text = t
