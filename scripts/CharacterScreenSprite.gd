extends Sprite2D

class_name CharacterScreenObject


enum Team 
{
	Player1,
	Player2
}

@export var is_selected: bool
@export var team: Team

@onready var TXT = $RichTextLabel

func _init(argTeam: int = 0):
	is_selected = false
	if argTeam == 0:
		team = Team.Player1
	if argTeam == 1:
		team = Team.Player2
	texture = preload("res://textures/txt_character.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var SHOW_DEBUG = true
	if SHOW_DEBUG:
		TXT.visible = true
	else:
		TXT.visible = false
	if team==Team.Player1:
		TXT.text = "p1"
		flip_h = false
	if team==Team.Player2:
		TXT.text = "cpu"
		flip_h = true
