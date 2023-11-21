extends Area2D


var particleBoostExplosionScene

@export var isBoostPlus = false


func _ready():
	particleBoostExplosionScene = load("res://Scenes/Particles/particle_glasswall_explosion.tscn")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if(body.is_in_group('Player')):
		body.hitGlassWall(isBoostPlus)
		
		var instanceParticle = particleBoostExplosionScene.instantiate()
		instanceParticle.position = global_position
		get_tree().current_scene.add_child(instanceParticle)
		
		queue_free()
