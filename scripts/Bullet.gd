extends Node2D

@export var direction = Vector2(-1,0)
@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@export var speed = 100

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	path_follow.progress += speed * delta



func _on_bullet_area_body_entered(body):
	if(body.is_in_group('Player')):
		body.hit()
		queue_free()
