extends KinematicBody2D

var index = 0

onready var ray = $RayCast2D
var grid_size = 16
var inputs = {
	'ui_up': Vector2.UP,
	'ui_down': Vector2.DOWN,
	'ui_left': Vector2.LEFT,
	'ui_right': Vector2.RIGHT
}

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			if $Tween.is_active() == false:
				move(dir)
			
func move(dir):
	var game = get_parent()

	if dir in inputs:
		print("Direção mapeada:", dir)
		var vector_pos = inputs[dir] * grid_size
		ray.cast_to = vector_pos
		ray.force_raycast_update()
		$Tween.interpolate_property(
			self, "position", 
			position, position + vector_pos, 0.15, 
			Tween.TRANS_SINE,
			Tween.EASE_IN_OUT
		)

		if !ray.is_colliding():
			$Tween.start()
			game.moves += 1
		else:
			var collider = ray.get_collider()
			if collider.is_in_group('box') and collider.move(dir):
				$Tween.start()
				game.moves += 1
	else:
		print("Erro: Direção não mapeada -", dir)

func _on_Tween_tween_all_completed():
	get_parent().check_end()
	
func get_direction_from_arrow(arrow):
	match arrow.name:
		"seta_cima":
			return Vector2.UP
		"seta_baixo":
			return Vector2.DOWN
		"seta_esq":
			return Vector2.LEFT
		"seta_dir":
			return Vector2.RIGHT
		_:
			print("Seta não reconhecida:", arrow.name)
			return Vector2.ZERO


