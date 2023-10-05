extends Area2D

@export var direction = Vector2(-1,0)
@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
		position =  position + direction 

func _on_body_entered(body):
	if(body.is_in_group('Player')):
		body.hit()
		queue_free()
