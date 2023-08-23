extends CharacterBody2D

var oldDirection = Vector2.ZERO
const SPEED = 750.0



func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down").normalized()
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		oldDirection = direction
	else:
		velocity = oldDirection * SPEED
	move_and_slide()
