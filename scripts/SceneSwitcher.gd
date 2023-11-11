extends Node

var current_level
var anim
var canvas
var inGameMenu

var next_level = null

func _ready():
	current_level = $MainMenu
	anim = $AnimationPlayer
	canvas = $CanvasLayer
	inGameMenu = $CanvasLayer/InGameMenu
	current_level.connect("level_changed",Callable(self, "handle_level_changed"))
	inGameMenu.visible = false
	GameManager.inGameMenu = inGameMenu
	
func handle_level_changed(level_name_to_load: String):
	print("load : " + level_name_to_load)
	var level_path = "res://Scenes/Levels/" + level_name_to_load + ".tscn"
	if ResourceLoader.exists(level_path):
		next_level = load(level_path).instantiate()
	else:
		next_level = load("res://Scenes/Levels/MainMenu.tscn").instantiate()
		
	print("nextlevel : " + level_path)
	anim.play("fade_in")
	canvas.layer = 5



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
			canvas.layer = -1
