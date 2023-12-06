extends Node2D


signal level_changed(level_name)

@export var level_name = 'level'
@export var nbBaseBoost = 1

func _ready():
	GameManager.resetTimer()
	GameManager.nbBaseBoost = nbBaseBoost
	GameManager.level = self

func emitSignalNextLevel():
	print(level_name)
	emit_signal("level_changed", GameManager.getNextLevel())
	GameManager.closeEndGameMenu()
	
func emitSignalLevel():
	print(level_name)
	emit_signal("level_changed", level_name)
	
func emitSignalMenu():
	print(level_name)
	GameManager.closeEndGameMenu()
	GameManager.closeInGameMenu()
	emit_signal("level_changed", "Menu")
