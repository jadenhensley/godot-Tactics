extends RichTextLabel

@onready var TEXT_PIECES: Array[String] = [
"Current Turn:",
"Turns Left:",
"Current Input Mode:"
]

@export var sharedData: ActionData

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var paramA = ""
	var paramB = ""
	var paramC = ""
	if (sharedData != null):
		match sharedData.current_turn:
			ActionData.Team.Player:
				paramA = "Team Player"
			ActionData.Team.CPU:
				paramA = "Team Computer"
		match sharedData.current_mode:
			ActionData.Mode.PlacingUnit:
				paramC = "(placing units)"
			ActionData.Mode.SelectingUnit:
				paramC = "(selecting units)"
			ActionData.Mode.MovingUnit:
				paramC = "(moving units)"
			ActionData.Mode.AttackingEnemy:
				paramC = "(attacking enemy)"
		paramB = str(sharedData.turns_left)
	text = "" + TEXT_PIECES[0] + "\n" + paramA + "\n\n" + TEXT_PIECES[1] + " " + paramB + "\n\n" + TEXT_PIECES[2] + paramC
