extends Node

var next = 0;
var audioStreamPlayers : Array[AudioStreamPlayer]
@export var count = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	if get_child_count() == 0:
		print("No audio player")
		return
	
	var child = get_child(0);
	if child is AudioStreamPlayer:
		audioStreamPlayers.append(child)
		
		for i in range(count):
			var duplicate : AudioStreamPlayer = child.duplicate()
			add_child(duplicate)
			audioStreamPlayers.append(duplicate)


func playSound(audioFile):
	if !audioStreamPlayers[next].playing:
		audioStreamPlayers[next].stream = audioFile
		audioStreamPlayers[next].play()
		next += 1
		next %= audioStreamPlayers.size()

func modifySound(value):
	for asp in audioStreamPlayers:
		asp.volume_db = (value)
		
