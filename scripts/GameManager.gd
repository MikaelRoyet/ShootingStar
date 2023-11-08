extends Node


signal my_signal_boost
signal my_signal_speed
signal my_signal_time

var isLevelStarted = false
var level
var timeLevelStart
var time = 0
var isRunning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	isRunning = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(isRunning):
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
