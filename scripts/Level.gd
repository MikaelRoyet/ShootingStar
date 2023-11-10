extends Node2D


signal level_changed(level_name)

@export var level_name = 'level'

func _ready():
	pass

func emitSignalNextLevel():
	print(level_name)
	emit_signal("level_changed", GameManager.getNextLevel(level_name))
	
func emitSignalLevel():
	print(level_name)
	emit_signal("level_changed", level_name)
	
func emitSignalMenu():
	print(level_name)
	emit_signal("level_changed", "Menu")
