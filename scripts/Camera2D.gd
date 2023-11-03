extends Camera2D

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0
var shakeFade: float = 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		offset = randomOffset()

 
func applyShake(strength, fade):
	shake_strength = strength
	shakeFade = fade
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))
	
