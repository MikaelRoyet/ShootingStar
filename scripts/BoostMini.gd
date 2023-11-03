extends Area2D

var particleBoostExplosionScene
var particleBoost


func _ready():
	particleBoostExplosionScene = load("res://Scenes/Particles/particle_boost_mini_explosion.tscn")
	particleBoost = $Particle_Boost


func _on_body_entered(body):
	if(body.is_in_group('Player')):
		body.booster("minibooster")
		
		var instanceParticle = particleBoostExplosionScene.instantiate()
		instanceParticle.position = global_position
		get_tree().current_scene.add_child(instanceParticle)
		queue_free() 
		
		

