extends RichTextLabel

@onready var TEXT = "In the lead: "
@onready var TEXT2 = "Currently placing: "
@export var sharedData: ActionData

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var param = ""
	if sharedData != null:
		if sharedData.leading_team == ActionData.Team.Player:
			param = "Team Player"
		if sharedData.leading_team == ActionData.Team.CPU:
			param = "Team Computer"
	text = TEXT + param
	if sharedData != null:
		var param2 = ""
		match sharedData.selected_object:
			Character.BoardObject.Mage:
				param2 = "Mage Unit"
			Character.BoardObject.Fighter:
				param2 = "Fighter Unit"
			Character.BoardObject.Archer:
				param2 = "Archer Unit"
		text += "\n" + TEXT2 + param2
