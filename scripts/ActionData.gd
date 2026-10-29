extends Node

class_name ActionData

enum Mode
{
	PlacingUnit,
	SelectingUnit,
	MovingUnit,
	AttackingEnemy
}

enum Team
{
	Player,
	CPU
}

@export var current_turn: Team = Team.Player
@export var turns_left: int = 30
@export var selected_object: Character.BoardObject = Character.BoardObject.Fighter
@export var leading_team: Team = Team.Player
@export var current_mode: Mode = Mode.PlacingUnit
@export var can_place: bool = false
@export var can_select: bool = false
@export var can_move: bool = false
@export var can_attack: bool = false
