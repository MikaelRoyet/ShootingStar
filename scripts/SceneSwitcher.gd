extends Node

var current_level
var anim
var canvas
var inGameMenu
var endGameMenu

var next_level = null

func _ready():
	current_level = $MainMenu
	anim = $AnimationPlayer
	canvas = $CanvasLayerTransition
	inGameMenu = $CanvasLayerInGameMenu/InGameMenu
	endGameMenu = $CanvasLayerEndGameMenu/EndGameMenu
	current_level.connect("level_changed",Callable(self, "handle_level_changed"))
	inGameMenu.visible = false
	endGameMenu.visible = false
	GameManager.inGameMenu = inGameMenu
	GameManager.endGameMenu = endGameMenu
	GameManager.musicPlayer = $MusicPlayer
	GameManager.sfxPlayers = $sfxPlayers
	
	
func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if(GameManager.isPause):
			print("unpause")
			GameManager.unpause()
			get_tree().paused = false
		else:
			print("pause")
			GameManager.pause()
			get_tree().paused = true

	
func handle_level_changed(level_name_to_load: String):
	print("load : " + level_name_to_load)
	var level_path = "res://Scenes/Levels/" + level_name_to_load + ".tscn"
	if ResourceLoader.exists(level_path):
		next_level = load(level_path).instantiate()
	else:
		next_level = load("res://Scenes/Levels/MainMenu.tscn").instantiate()
		
	print("nextlevel : " + level_path)
	canvas.layer = 10
	print("ON COMMENCE LA")
	anim.play("fade_in")




func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"fade_in":
			call_deferred("add_child", (next_level))
			current_level.queue_free()
			current_level = next_level
			current_level.connect("level_changed",Callable(self, "handle_level_changed"))
			next_level = null
			anim.play("fade_out")

		"fade_out":
			print("ON FINI LA")
			canvas.layer = -1
