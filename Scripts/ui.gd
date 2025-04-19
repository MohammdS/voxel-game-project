extends CanvasLayer

@onready var ctrl = $ControlsDialog

func _ready():
	ctrl.hide()    # make sure it starts hidden

func _input(event):
	# this runs before any UI node can consume the key
	if event.is_action_pressed("toggle_controls"):
		if ctrl.visible:
			ctrl.hide()
		else:
			ctrl.popup_centered()
