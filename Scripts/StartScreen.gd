extends Control

var FILE_NAME = "user://game-data.json"

var controlScreen = load("res://Scenes/Menu/controlsScreen.tscn").instance()

func _ready():
	pass


func _update_current_phase(current_value):
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	var text = JSON.print(current_value.phase)
	file.store_string(text)
	print("texto:", text)
	file.close()
	

func _on_jogarBnt_pressed():
	var current_phase_temp = Current_phase.new()
	_update_current_phase(current_phase_temp)
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
