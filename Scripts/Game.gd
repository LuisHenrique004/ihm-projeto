extends Node2D

var game_end = false
var moves = 0
var FILE_NAME = "user://game-data.json"

func _process(_delta):
	$MovesLabel.text = 'Passos: ' + str(moves) + '/10'

func check_end():
	if game_end == false:
		var spots = $Spots.get_child_count()
		for i in $Spots.get_children():
			if i.occupied:
				spots -= 1
	
		if spots == 0:
			var current_phase = Current_phase.new()
			var temp = _read_current_phase()
			if temp != null:
				current_phase.phase = temp
			if current_phase.phase == 2:
				print("entrou no if")
				$AcceptDialog.dialog_text = "Você chegou\nao final do jogo\nclique em ok\npara voltar ao\nmenu principal"
			$AcceptDialog.popup()
			game_end = true
			
func _update_current_phase(current_value):
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	var text = JSON.print(current_value.phase)
	file.store_string(text)
	print("texto:", text)
	file.close()
	
func _read_current_phase():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var result = JSON.parse(file.get_as_text())
		file.close()
		print(result)
		return result.result
	else:
		printerr("No saved data!")
	
func _on_AcceptDialog_confirmed():
	var current_phase = Current_phase.new()
	var temp = _read_current_phase()
	if temp != null:
		current_phase.phase = temp
		
	print("Current_phase: ", current_phase)
	if current_phase.phase == 0:
		_update_current_phase(current_phase)
		
	print("Valor de current_phase antes do incremento:", current_phase.phase)  # Adicionando o print
	current_phase.phase += 1
	if current_phase.phase <= 2:
		_update_current_phase(current_phase)	
	else:
		var current_phase_temp = Current_phase.new()
		_update_current_phase(current_phase_temp)
		get_tree().change_scene("res://Scenes/Menu/StartScreen.tscn")
		 
	print("Valor de current_phase após incremento:", current_phase.phase)  # Adicionando o print	
		
	match str(current_phase.phase):
		"1":
			print("Mudando para Game2.tscn")
			get_tree().change_scene("res://Scenes/Game/Game2.tscn")
		"2":
			print("Mudando para Game3.tscn")
			get_tree().change_scene("res://Scenes/Game/Game3.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu/StartScreen.tscn")
	
func _on_AcceptDialog_erro_confirmed():
	get_tree().reload_current_scene()
