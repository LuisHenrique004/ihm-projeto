extends Control

signal controles_closed

func _ready():
	pass

func _on_returnBnt_pressed():
	queue_free()
	emit_signal("controles_closed")
