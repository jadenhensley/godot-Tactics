extends Node2D

class_name Character

enum BoardObject
{
	Mage,
	Fighter,
	Archer,
}

const SCENE_SCREENOBJ = preload("res://scenes/CharacterScreenSprite.tscn")

@onready var grid_size: Vector2i = Vector2i(12,8);
@onready var cell_size: int = 32;
@onready var screen_offset: Vector2i = Vector2i(64,64);

@export var my_class: BoardObject
@export var my_screen_obj: CharacterScreenObject
@export var x_pos: int
@export var y_pos: int
@export var team: ActionData.Team

func _init(argClass: BoardObject = BoardObject.Mage, argX: int = -1, argY: int = -1, argTeam: ActionData.Team = ActionData.Team.Player):
	my_class = argClass
	my_screen_obj = SCENE_SCREENOBJ.instantiate()
	x_pos = argX
	y_pos = argY
	team = argTeam

func _ready():
	my_screen_obj.global_position.x = screen_offset.x + (x_pos * cell_size) + (cell_size / 2);
	my_screen_obj.global_position.y = screen_offset.y + (y_pos * cell_size) + (cell_size / 2);
	match team:
		ActionData.Team.Player:
			my_screen_obj.team = CharacterScreenObject.Team.Player1
		ActionData.Team.CPU:
			my_screen_obj.team = CharacterScreenObject.Team.Player2
	match my_class:
		BoardObject.Mage:
			my_screen_obj.frame = 3
		BoardObject.Fighter:
			my_screen_obj.frame = 4
		BoardObject.Archer:
			my_screen_obj.frame = 5
	add_child(my_screen_obj)
