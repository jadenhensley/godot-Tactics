extends VBoxContainer

@onready var buttons: Array[Button] = [
	$Button,
	$Button2,
	$Button3,
	$Button4,
	$Button5,
	$Button6,
] # note: index is 0-based.

@onready var is_toggled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_toggled:
		buttons[0].text = "Hide input options."
		buttons[1].visible = true
		buttons[2].visible = true
		buttons[3].visible = true
		buttons[4].visible = true
		buttons[5].visible = true

	else:
		buttons[0].text = "Show input options."
		buttons[1].visible = false
		buttons[2].visible = false
		buttons[3].visible = false
		buttons[4].visible = false
		buttons[5].visible = false


func _on_button_pressed():
	is_toggled = not is_toggled
