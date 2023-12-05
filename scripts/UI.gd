extends Control


var valueBoost
var valueSpeed
var valueTimer
var valueTime
var hBoxContainerBoost

var nbBoost
var tabBoostUI = []


var boostUIcomponent = load("res://Scenes/UI/BoostUiComponent.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	hBoxContainerBoost = $VBoxContainer/HBoxContainer
	valueSpeed = $VBoxContainer/HBoxContainer2/ValueSpeed
	valueTimer = $Panel/HBoxContainer/ValueTimer
	var emmiter = GameManager
	emmiter.my_signal_boost.connect(majBoost)
	emmiter.my_signal_speed.connect(majSpeed)
	emmiter.my_signal_time.connect(majTime)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func majBoost(boost):
	GameManager.isBoostDataStartSend = true
	nbBoost = boost
	for i in range(tabBoostUI.size()):
		tabBoostUI[i].queue_free()
	tabBoostUI.clear()
	for i in range(nbBoost):
		var instanceBoostUIcomponent = boostUIcomponent.instantiate()
		tabBoostUI.append(instanceBoostUIcomponent)
		hBoxContainerBoost.add_child(instanceBoostUIcomponent)
	
	
func majSpeed(speed):
	valueSpeed.text = str(speed)
	
func majTime(time):
	valueTimer.text = str(time)
