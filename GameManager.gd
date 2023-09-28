extends Node


signal my_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func sendBoostToUI(boost):
	print("sendboostui")
	emit_signal("my_signal", boost)
	#connect("my_signal", self, "signal_handler")
	pass
