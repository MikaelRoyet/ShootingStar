extends Panel


var valueBoost

# Called when the node enters the scene tree for the first time.
func _ready():
	
	valueBoost = $HBoxContainer/ValueBoost
	var emmiter = GameManager
	emmiter.my_signal.connect(majBoost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func majBoost(boost):
	valueBoost.text = str(boost)
