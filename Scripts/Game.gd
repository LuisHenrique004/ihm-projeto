extends Node2D

var game_end = false
var moves = 0

func _process(_delta):
	$MovesLabel.text = 'Passos: ' + str(moves)

func check_end():
	if game_end == false:
		var spots = $Spots.get_child_count()
		for i in $Spots.get_children():
			if i.occupied:
				spots -= 1
	
	
		if spots == 0:
			$AcceptDialog.popup()
			game_end = true
	else:
		print("algo")

func _on_AcceptDialog_confirmed():
	get_tree().reload_current_scene()


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu/StartScreen.tscn")
