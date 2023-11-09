extends Control

signal level_changed(level_name)

@export var level_name = 'level'

var LevelHBox = load("res://prefab/UI/LevelHBox.tscn")
var worldSelected = 0
var levelDataDict

@onready var gridLevel = $LevelSelectContainer/GridLevel
@onready var worldTitle = $LevelSelectContainer/HBoxContainer/LevelSelectTitle
@onready var buttonNext = $LevelSelectContainer/HBoxContainer/NextLevel
@onready var buttonPrevious = $LevelSelectContainer/HBoxContainer/PreviousLevel
# Called when the node enters the scene tree for the first time.
func _ready():
	levelDataDict = GameManager.levelDataDict
	generateLevels()
	
	$MainMenuContainer/Play.grab_focus()
	$LevelSelectContainer.visible = false
	GameManager.setLevel(self)
	for button in get_tree().get_nodes_in_group("LevelsButtons"):
		button.connect("pressed", self, "StartLevel", [button])
	
	worldTitle.text  = GameManager.matchWorldName(worldSelected)
	if worldSelected - 1 < 0:
		buttonPrevious.disabled = true

	if worldSelected + 1 > GameManager.worldNameArray.size()-1:
		print(worldSelected + 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_play_button_pressed():
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



func _on_SceneSwitcher_level_changed(level_name):
	pass # Replace with function body.

func generateLevels():

	for level in levelDataDict:
		if levelDataDict[level]["world"] == worldSelected:
			var levelHBox = LevelHBox.instance()
			gridLevel.add_child(levelHBox)
			levelHBox.setAllValues(level, levelDataDict[level]["name"], GameManager.timeDict[level],
			 GameManager.getMedal(GameManager.timeDict[level], level))

func changeLevel(newWorld):
	for level in gridLevel.get_children():
		gridLevel.remove_child(level)
		
	worldTitle.text  = GameManager.matchWorldName(newWorld)
	worldSelected = newWorld
	generateLevels()

func _on_PreviousLevel_pressed():
	changeLevel(worldSelected - 1)
	if worldSelected - 1 < 0:
		buttonPrevious.disabled = true
	buttonNext.disabled = false


func _on_NextLevel_pressed():
	changeLevel(worldSelected + 1)
	if worldSelected + 1 > GameManager.worldNameArray.size()-1:
		print(worldSelected + 1)
		buttonNext.disabled = true
	buttonPrevious.disabled = false
