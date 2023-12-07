extends Control


signal signal_music(value)
signal signal_sfx(value)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_slider_sfx_value_changed(value):
	emit_signal("signal_sfx", value)


func _on_slider_music_value_changed(value):
	emit_signal("signal_music", value)
