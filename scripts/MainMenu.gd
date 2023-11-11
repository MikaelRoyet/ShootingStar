extends Control

signal level_changed(level_name)

@export var level_name = 'level'

var levelButtonScene = load("res://Scenes/UI/levelButton.tscn")
var levelDataDict

@onready var gridLevel = $GridLevel
# Called when the node enters the scene tree for the first time.
func _ready():
	levelDataDict = GameManager.levelDataDict
	generateLevels()
	
	$MainMenuContainer/PlayButton.grab_focus()
	#GameManager.setLevel(self)
	for button in get_tree().get_nodes_in_group("LevelsButtons"):
		button.pressed.connect(func():StartLevel(button))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed(button):
	emit_signal("level_changed", button.name)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_Play_pressed():
	$LevelSelectContainer.visible = true
	


func _on_Options_pressed():
	$OptionsContainer.visible = true
	$LevelSelectContainer.visible = false

func _on_Quit_pressed():
	get_tree().quit()



func StartLevel(button):
	emit_signal("level_changed", button.name)

func _on_MuteSound_pressed():
	pass # Replace with function body.


func _on_MuteMusic_pressed():
	pass # Replace with function body.


func generateLevels():

	for level in levelDataDict:
		var levelHBox = levelButtonScene.instantiate()
		gridLevel.add_child(levelHBox)
		levelHBox.setAllValues(level, levelDataDict[level]["name"])

