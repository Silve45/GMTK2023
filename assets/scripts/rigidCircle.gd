extends RigidBody2D
@export_group("speed")
@export var xVelocity = 200
@export var yVelocity = 200

@onready var sprite = $Sprite2D
@onready var particles = $CPUParticles2D
@onready var deathTimer = $CPUParticles2D/deathTimer
var velocity = Vector2()

var maxVelocity = null 
var minVelocity = null

#var maxVelocity = Vector2(200, 200)

func _ready():
	deathTimer.set_wait_time(particles.get_lifetime())
	velocity = Vector2(xVelocity ,yVelocity)
#	maxVelocity = xVelocity
#	minVelocity = xVelocity * -1 

func _process(delta):
	pass
#	_speed_up()
#	print(Globals.score)
#	var maxMin = str( "max min are ",maxVelocity,", ", minVelocity)
#	var speedNow = str( "speed is now ",velocity.x,", ", velocity.y)
#	print(maxMin)
#	print(speedNow)
#	_cap_speed()

func _cap_speed():
	#maxSpeed
	if velocity.x >= maxVelocity:
		velocity.x = maxVelocity
	
	if velocity.y >= maxVelocity:
		velocity.y = maxVelocity
		
	#minSpeed
	if velocity.x <= minVelocity:
		velocity.x = minVelocity
	
	if velocity.y <= minVelocity:
		velocity.y = minVelocity

var one = false
var two = false
var three = false 
var four = false 
var five = false
func _speed_up():
	if Globals.score == 10 and one == false:
		one = true
		_speed_up_logic()
	if Globals.score == 20 and two == false:
		two = true
		_speed_up_logic()
	if Globals.score == 30 and three == false:
		three = true
		_speed_up_logic()
	if Globals.score == 40 and four == false:
		four = true
		_speed_up_logic()
	if Globals.score == 50 and five == false:
		five = true
		_speed_up_logic()



func _speed_up_logic():
	if velocity.x > 0:
		velocity.x += 100
	if velocity.x < 0:
		velocity.x -= 100
	
	if velocity.y > 0:
		velocity.y += 100
	if velocity.y < 0:
		velocity.y -= 100
	
	maxVelocity += 100
	minVelocity -= 100
	print("speed up!!")
#	xVelocity +=100
##	yVelocity += 100
#	velocity = Vector2(xVelocity ,yVelocity)

func _physics_process(delta):
	_movementStuff(delta)

func _movementStuff(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: 
		velocity = velocity.bounce(collision_info.get_normal())
		

func _on_hurt_box_body_entered(body):
	_dead()
	print("dead")

func _on_hurt_box_area_entered(area):
	pass # Replace with function body.

func _dead():
	#sound effect here
	particles.emitting = true
	particles.one_shot = true
	sprite.visible = false
	velocity = Vector2.ZERO
	deathTimer.start()#sets the death var to true


func _on_death_timer_timeout():
	queue_free()
	#death thing here
