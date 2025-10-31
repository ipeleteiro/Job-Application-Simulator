extends Panel

@onready var email: Button = $TabContainer/Email/ScrollContainer/Emails/Email
@onready var email_container: VBoxContainer = $TabContainer/Email/ScrollContainer/Emails
@onready var tab_container: TabContainer = $TabContainer

# Email Content
@onready var sender: RichTextLabel = $TabContainer/Email/Panel/Sender/Sender
@onready var title: RichTextLabel = $TabContainer/Email/Panel/Title/Title
@onready var text_1: RichTextLabel = $TabContainer/Email/Panel/Body/ScrollContainer/VBoxContainer/Text1
@onready var text_2: RichTextLabel = $TabContainer/Email/Panel/Body/ScrollContainer/VBoxContainer/Text2
@onready var link_to_minigame: Button = $TabContainer/Email/Panel/Body/ScrollContainer/VBoxContainer/Button


func _ready() -> void:
	link_to_minigame.connect("make_new_tab", create_tab)
	email.button_pressed = true

func _process(delta: float) -> void:
	for c in emails.keys():
		var company = emails[c]
		company["timer"] += delta
		var email_id = company["current_email"]
		var email_info = company["emails"][email_id]
		if email_info["time_offset"] < company["timer"] and email_info["added"] == false:
			email_info["added"] = true
			create_email(email_info, c, email_id, company["sender"])


func create_email(email_info, company, id, email_sender):
	# add to email group preload("uid://bdmnmapyxh3o0")
	var email_scene = load("uid://buijaojbxhbi0")
	var new_email: Button = email_scene.instantiate()
	new_email.name = "Email" + id
	new_email.company = company
	new_email.status = "unopened"
	new_email.set_sender(email_sender)
	new_email.set_title(email_info["title"])
	
	new_email.button_group = email.button_group
	email_container.add_child(new_email)
	email_container.move_child(new_email, 0)
	new_email.connect("email_opened", load_email)

func load_email(company, emailID):
	var cur_email = emails[company]["emails"][emailID]
	sender.text = "From: " + emails[company]["sender"]
	title.text = cur_email["title"]
	text_1.text = cur_email["text"]
	text_2.text = emails[company]["signature"]
	if cur_email["link"] != "":
		link_to_minigame.visible = true
		#button.image =
		link_to_minigame.link_to_minigame_scene = cur_email["link"]
		link_to_minigame.company = company
		link_to_minigame.emailID = emailID
	else:
		link_to_minigame.visible = false


func create_tab(link_to_minigame_scene, company, emailID):
	for tab in tab_container.get_children():
		if minigames[link_to_minigame_scene][0] in tab.name:
			print("no duplicates")
			return
	var tab_scene = load(link_to_minigame_scene)
	var new_tab = tab_scene.instantiate()
	new_tab.name = minigames[link_to_minigame_scene][0]
	new_tab.connect(minigames[link_to_minigame_scene][1], end_minigame)
	active_minigames[new_tab.name] = {"company":company, "emailID":emailID}
	tab_container.add_child(new_tab)

var minigames = {"res://Scenes/mama's_burgeria.tscn":["Mama's Burgeria", "mama_results"]}
var active_minigames = {}

func end_minigame(minigame_name, result):
	var minigame_info = active_minigames[minigame_name]
	var company = minigame_info["company"]
	var emailID = minigame_info["emailID"]
	emails[company]["timer"] = 0
	if result:
		var cur_email = emails[company]["emails"][emailID]
		emails[company]["current_email"] = cur_email["next_email_id"]
	else:
		emails[company]["current_email"] = "reject"


var emails = {
	"CapitalTwo":
	{
	"sender":"aurora-patel@capitaltwo.co.uk",
	"opener":"Hello " + Global.player_name + ",",
	"signature": "Best regards,\nAurora Patel\nCapitalTwo UK Recruitment",
	"current_email":"0",
	"timer": 0,
	"emails":{"reject": { "time_offset": 0,
						"added": false,
						"title":"Update on your Application",
						"text":"Unfortunatelly, we will not be moving forward with your application at this moment.",
						"link":"",
						"next_email_id":""},
				"offer": { "time_offset": 0,
						"added": false,
						"title":"Congratulations!",
						"text":"You got the job!",
						"link":"link to scene",
						"next_email_id":""},
				"0":{"time_offset": 1,
					"added": false,
					"title":"New opening at Company",
					"text":"You should apply fr fr",
					"link":"res://Scenes/mama's_burgeria.tscn",
					"next_email_id":"1"},
				"1":{"time_offset": 2,
					"added": false,
					"title":"WOWE A NEW EMAIL???",
					"text":"You should apply fr fr",
					"link":"link to scene",
					"next_email_id":"1"}
			}
	},
	"Lockpick Geoffrey":
	{
	"sender":"careers-noreply@lockpickgeoffrey.com",
	"opener":"Dear " + Global.player_name + ",",
	"signature": "Thank you,\nLockpick Geoffrey Recruitment Team",
	"current_email":"0",
	"timer": 0,
	"emails":{"reject": { "time_offset": 0,
						"added": false,
						"title":"Update on your Application",
						"text":"Unfortunatelly, we will not be moving forward with your application at this moment.",
						"link":"",
						"next_email_id":""},
				"offer": { "time_offset": 0,
						"added": false,
						"title":"Congratulations!",
						"text":"You got the job!",
						"link":"link to scene",
						"next_email_id":""},
				"0":{"time_offset": 3,
					"added": false,
					"title":"New opening at Company",
					"text":"You should apply fr fr",
					"link":"link to scene",
					"next_email_id":"1"},
				"1":{"time_offset": 0,
					"added": false,
					"title":"New opening at Company",
					"text":"You should apply fr fr",
					"link":"link to scene",
					"next_email_id":"1"}
			}
	},
	"Helpful Advice":
	{
	"sender":"the-team@tips.com",
	"opener":"Hello " + Global.player_name + "!",
	"signature": "Good luck!\nJob Application Simulation Team",
	"current_email":"0",
	"timer": 0,
	"emails":{"0":{"time_offset": 0,
					"added": false,
					"title":"Some tips!",
					"text":"wowe",
					"link":"",
					"next_email_id":"1"},
				"1":{"time_offset": 0,
					"added": false,
					"title":"New opening at Company",
					"text":"You should apply fr fr",
					"link":"link to scene",
					"next_email_id":"1"}
			}
	}
}
