extends CharacterBody2D

var oldDirection = Vector2.ZERO
var direction

const CONST_DASH_DISTANCE = 300
var CrossHair

var collision

#Sprite
var spriteCharacter

#Trail
var current_trail

#Speed
var speed = CONST_SPEED
var speedToGo = CONST_SPEED
const CONST_SPEED_INCR = 15
const CONST_SPEED = 700.0
const CONST_SPEED_MULTI = 2
const CONST_SPEED_NORMAL = 1
const CONST_SPEED_SLOW = 0.7
const CONST_SPEED_SLOW_HIT = 0.5

#WallHit
const CONST_DURATION_WALLHIT = 1
var durationWallHitTimer : Timer
var durationBulletHitTimer : Timer
var isWallHit = false
var isBullletHit = false

#Boost
var CONST_NB_BOOST_MAX = 5
var nb_boost = CONST_NB_BOOST_MAX

#Shield
const CONST_CD_SHIELD = 5
const CONST_CD_SHIELD_RESET = 0.5
const CONST_SHIELD_DURATION = 2
var shieldCdTimer : Timer
var shieldDurationTimer : Timer
var is_vulnerable = true
var cdShield = 0
var is_onCd = false
var particleShield

#Booster
const CONST_BOOSTER_DURATION = 200
var isOnBooster = false
var boosterDurationTimer

#Trail
var trail

#Particles
var wallCollisionParticles = load("res://Scenes/Particles/particle_wall_hit.tscn")

func _ready():
	CrossHair = $CrossHair
	shieldCdTimer = $ShieldCd
	shieldDurationTimer = $DurationShield
	durationWallHitTimer = $DurationWallHit
	durationBulletHitTimer = $DurationBulletHit
	boosterDurationTimer = $DurationBooster
	particleShield = $ShieldParticles
	trail = $Line2D
	spriteCharacter = $Sprite2D
	spriteCharacter.modulate = Color(255,255,255,255)
	GameManager.sendBoostToUI(nb_boost)


func _process(delta):
	
	if(Input.is_action_just_pressed("shield")):
		shield()
		
	if(Input.is_action_just_pressed("acceleration")):
		if nb_boost > 0 && !isBullletHit && !isOnBooster:
			nb_boost -= 1	
			GameManager.sendBoostToUI(nb_boost)
			booster()

	if(Input.is_action_just_released("acceleration")):
		if(isWallHit && isBullletHit):
			set_speed(CONST_SPEED_SLOW)
		elif(isOnBooster):
			set_speed(CONST_SPEED_MULTI)
		else:
			set_speed(CONST_SPEED_NORMAL)

func _physics_process(delta):


	if(speed > speedToGo):
		speed -= CONST_SPEED_INCR
	elif(speed < speedToGo):
		speed += CONST_SPEED_INCR
	
	GameManager.sendSpeedToUI(speed)
	trail.set_color(speed)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction != Vector2.ZERO:
		velocity = (velocity + direction * 75).normalized() * speed
		oldDirection = direction
	else:
		velocity = (velocity + oldDirection * 75).normalized() * speed
	
	CrossHair.global_position = (oldDirection * CONST_DASH_DISTANCE) + position

	
	collision = move_and_collide(velocity * delta)
	if collision:
		hitWall(collision)
		print("I collided with ", collision.get_collider().name)

	
func hitWall(collision):
	var instanceParticle = wallCollisionParticles.instantiate()
	instanceParticle.position = global_position
	get_tree().current_scene.add_child(instanceParticle)
	velocity = velocity.bounce(collision.get_normal())
	set_speed(CONST_SPEED_SLOW)
	durationWallHitTimer.start(CONST_DURATION_WALLHIT)
	boosterDurationTimer.stop()
	isOnBooster = false
	
	isWallHit = true



func set_speed(multiplicateur):
	speedToGo = CONST_SPEED * multiplicateur



func shield():
	if(!is_onCd):
		particleShield.emitting = true
		
		set_vulnerable(false)
		shieldCdTimer.start(CONST_CD_SHIELD)
		shieldDurationTimer.start(CONST_SHIELD_DURATION)
		spriteCharacter.modulate = Color(150,0,0,255)
		is_onCd = true
	
func set_vulnerable(status):
	is_vulnerable = status

func hit():
	if(is_vulnerable):
		print("hit2")
		set_speed(CONST_SPEED_SLOW_HIT)
		durationBulletHitTimer.start(CONST_DURATION_WALLHIT)
		boosterDurationTimer.stop()
		isOnBooster = false
		isBullletHit = true
	else:
		print("blocked")
		
		if(nb_boost < CONST_NB_BOOST_MAX):
			nb_boost += 1
			
		GameManager.sendBoostToUI(nb_boost)
		shieldCdTimer.stop()
		set_vulnerable(false)
		is_onCd = false
		spriteCharacter.modulate = Color(255,255,255,255)

func booster():
	set_speed(CONST_SPEED_MULTI)
	boosterDurationTimer.start(CONST_DURATION_WALLHIT)
	durationWallHitTimer.stop()
	isOnBooster = true
	print("bah wsh")


func _on_shield_cd_timeout():
	is_onCd = false


func _on_duration_wall_hit_timeout():
	set_speed(CONST_SPEED_NORMAL)
	isWallHit = false


func _on_duration_bullet_hit_timeout():
	set_speed(CONST_SPEED_NORMAL)
	isBullletHit = false

	
	
func _on_duration_shield_timeout():
	set_vulnerable(true)
	spriteCharacter.modulate = Color(255,255,255,255)


func _on_duration_booster_timeout():
	set_speed(CONST_SPEED_NORMAL)
	isOnBooster = false
