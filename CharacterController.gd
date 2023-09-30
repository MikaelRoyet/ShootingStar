extends CharacterBody2D

var oldDirection = Vector2.ZERO
var direction

const CONST_DASH_DISTANCE = 300
var CrossHair

var collision

#Sprite
var spriteCharacter

#Trail
var current_trail = Trail

#Speed
var speed = CONST_SPEED
const CONST_SPEED = 700.0
const CONST_SPEED_MULTI = 1.5
const CONST_SPEED_NORMAL = 1
const CONST_SPEED_SLOW = 0.5

#WallHit
const CONST_DURATION_WALLHIT = 1
var durationWallHitTimer : Timer

#Boost
var CONST_BOOST_MAX = 200
var boost = CONST_BOOST_MAX

#Shield
const CONST_CD_SHIELD = 5
const CONST_CD_SHIELD_RESET = 0.5
const CONST_SHIELD_DURATION = 2
var shieldCdTimer : Timer
var shieldDurationTimer : Timer
var is_vulnerable = true
var cdShield = 0
var is_onCd = false

func _ready():
	CrossHair = $CrossHair
	shieldCdTimer = $ShieldCd
	shieldDurationTimer = $DurationShield
	durationWallHitTimer = $DurationWallHit
	spriteCharacter = $Sprite2D
	spriteCharacter.modulate = Color(255,255,255,255)
	#makeTrail()


func _process(delta):
	print(position)
		
	if(Input.is_action_just_pressed("shield")):
		shield()
		
	if(Input.is_action_pressed("acceleration")):
		if boost > 0:
			boost -= 1	
			GameManager.sendBoostToUI(boost)
		else:
			set_speed(CONST_SPEED_NORMAL)	
		
	if(Input.is_action_just_pressed("acceleration")):
		if(boost > 0):
			set_speed(CONST_SPEED_MULTI)
			
	if(Input.is_action_just_released("acceleration")):
		set_speed(CONST_SPEED_NORMAL)	

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction != Vector2.ZERO:
		velocity = (velocity + direction * 75).normalized() * speed
		oldDirection = direction
	else:
		velocity = (velocity + oldDirection * 75).normalized() * speed
	
	CrossHair.global_position = (oldDirection * CONST_DASH_DISTANCE) + position
	# Using move_and_collide.
	collision = move_and_collide(velocity * delta)
	if collision:
		hitWall("collsion detections")
		print("I collided with ", collision.get_collider().name)



func swap():
	print("swwaappppappapapapapapaapapa")
	position = (oldDirection * CONST_DASH_DISTANCE) + position
	
func hitWall(info):
	print(info)
	set_speed(CONST_SPEED_SLOW)
	durationWallHitTimer.start(CONST_DURATION_WALLHIT)
	#rebond contre le mur
	velocity = (-oldDirection ).normalized() * speed
	
	#Acceleration juste apres le wallhit cancel le slow


func set_speed(multiplicateur):
	print("set speed to ", multiplicateur)
	speed = CONST_SPEED * multiplicateur



func shield():
	if(!is_onCd):
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
	else:
		print("blocked")
		boost = CONST_BOOST_MAX
		GameManager.sendBoostToUI(boost)
		shieldCdTimer.stop()
		set_vulnerable(false)
		is_onCd = false
		spriteCharacter.modulate = Color(255,255,255,255)

func _on_shield_cd_timeout():
	is_onCd = false


func _on_duration_wall_hit_timeout():
	set_speed(CONST_SPEED_NORMAL)


func _on_duration_shield_timeout():
	set_vulnerable(true)
	spriteCharacter.modulate = Color(255,255,255,255)

func makeTrail() -> void:
	current_trail = Trail.create()
	add_child(current_trail)
