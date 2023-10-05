extends Node


signal my_signal_boost
signal my_signal_speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func sendBoostToUI(boost):
	emit_signal("my_signal_boost", boost)
	pass

func sendSpeedToUI(speed):
	emit_signal("my_signal_speed", speed)
	pass
