extends CharacterBody2D
@export_group("speed")
@export var xVelocity = 500
@export var yVelocity = 500


func _ready():
	velocity = Vector2(xVelocity ,xVelocity)

func _process(delta):
#	_speed_up()
	print(velocity)

func _physics_process(delta):
	_movementStuff(delta)

func _speed_up():
	match [int(Globals.score)]:
		[100]:
			_speed_up_logic()
		[200]:
			_speed_up_logic()
		[300]:
			_speed_up_logic()
		[400]:
			_speed_up_logic()
		[500]:
			_speed_up_logic()

func _speed_up_logic():
	print("speed up!!")
#	xVelocity +=100
#	yVelocity += 100
	var newSpeed = Vector2(100,100)
	velocity += newSpeed

func _movementStuff(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: 
		velocity = velocity.bounce(collision_info.get_normal())
		
