extends Control

func _ready():
	pass


func _on_jogarBnt_pressed():
	get_tree().change_scene("res://Scenes/Game/Game.tscn")


func _on_fasesBnt_pressed():
	pass # Replace with function body.


func _on_controlesBnt_pressed():
	var controlScreen = load("res://Scenes/Menu/controlsScreen.tscn").instance()
	get_tree().current_scene.add_child(controlScreen)


func _on_sairBnt_pressed():
	get_tree().quit()
