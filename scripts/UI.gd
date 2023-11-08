extends Container


var valueBoost
var valueSpeed
var valueTimer
var valueTime

# Called when the node enters the scene tree for the first time.
func _ready():
	
	valueBoost = $VBoxContainer/HBoxContainer/ValueBoost
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
	valueBoost.text = str(boost)
	
func majSpeed(speed):
	valueSpeed.text = str(speed)
	
func majTime(time):
	valueTimer.text = str(time)
