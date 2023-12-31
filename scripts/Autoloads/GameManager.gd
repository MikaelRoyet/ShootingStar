extends Node


signal my_signal_boost
signal my_signal_speed
signal my_signal_time

var isLevelStarted = false
var level
var timeLevelStart
var time = 0
var isRunning = false

var player
var nbBaseBoost
var isBoostDataStartSend : bool = false

var inGameMenu
var endGameMenu
var isPause = false

#Data

var levelDataDict

#Audio
var musicPlayer : AudioStreamPlayer
var sfxPlayers

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level_data()
	isRunning = true
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !isBoostDataStartSend && player != null:
		sendBoostToUI(nbBaseBoost)
		player.nb_boost = nbBaseBoost
	
	if isRunning && player != null && player.velocity != Vector2(0,0):
		sendTimeToUI(delta)
		


func sendBoostToUI(boost):
	emit_signal("my_signal_boost", boost)

func sendSpeedToUI(speed):
	emit_signal("my_signal_speed", speed)
	
func sendTimeToUI(delta):
	time += delta
	emit_signal("my_signal_time", snapped(time,0.01))
	
	
	
func endLevel():
	isRunning = false
	endGameMenu.visible = true
	endGameMenu.get_parent().layer = 15
	
	
func startTimer():
	time = 0
	isRunning = true
	
func resetTimer():
	time = 0
	sendTimeToUI(time)
	

#UI functions
func pause():
	print("pause")
	inGameMenu.visible = true
	inGameMenu.get_parent().layer = 15
	isPause = true

func unpause():
	print("unpause")
	inGameMenu.visible = false
	inGameMenu.get_parent().layer = 1
	isPause = false


#Level change

func getNextLevel():
	return levelDataDict[level.level_name]["nextLevel"]

func closeEndGameMenu():
	endGameMenu.visible = false
	endGameMenu.get_parent().layer = 1
	isRunning = true
	
func closeInGameMenu():
	inGameMenu.visible = false
	inGameMenu.get_parent().layer = 1


#Load Data

func load_level_data():
	if not FileAccess.file_exists("res://data/level_data.json"):
		print("Error loading level_data.json")
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var file = FileAccess.open("res://data/level_data.json", FileAccess.READ)
	var data = file.get_as_text(false)
	var json = JSON.new()
	var error = json.parse(data)
	if error == OK:
		levelDataDict = json.data
		print(levelDataDict)
	else:
		print("Error parsing json")

#Audio

func changeMusicToLevel():
	musicPlayer.stream = AudioFile.levelMusic
	musicPlayer.play()

func changeMusicToMenu():
	musicPlayer.stream = AudioFile.menuMusic
	musicPlayer.play()
	
func playSfx(audioFile):
	sfxPlayers.playSound(audioFile)

func muteMusic():
	musicPlayer.stream_paused = true
	
func unmuteMusic():
	musicPlayer.stream_paused = false
