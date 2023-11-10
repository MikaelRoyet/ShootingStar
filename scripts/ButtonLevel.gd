extends HBoxContainer


@onready var button = $Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setAllValues(level, levelName):
	button.name = level
	button.text = levelName
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
