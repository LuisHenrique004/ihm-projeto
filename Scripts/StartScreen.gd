extends Control

var controlScreen = load("res://Scenes/Menu/controlsScreen.tscn").instance()

func _ready():
	pass


func _on_jogarBnt_pressed():
	controlScreen = load("res://Scenes/Menu/controlsScreen.tscn").instance()
	get_tree().current_scene.add_child(controlScreen)
	controlScreen.connect("controles_closed", self, "_on_controles_closed")
	
func _on_controles_closed():
	get_tree().change_scene("res://Scenes/Game/Game.tscn")

func _on_fasesBnt_pressed():
	pass
	
func _on_controlesBnt_pressed():
	controlScreen = load("res://Scenes/Menu/controlsScreen.tscn").instance()
	get_tree().current_scene.add_child(controlScreen)

func _on_sairBnt_pressed():
	get_tree().quit()
