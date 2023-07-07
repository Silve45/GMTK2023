extends CharacterBody2D
@export_group("speed")
@export var xVelocity = 200
@export var yVelocity = 200


func _ready():
	velocity = Vector2(xVelocity ,xVelocity)

func _physics_process(delta):
	_movementStuff(delta)
	
func _movementStuff(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info: 
		velocity = velocity.bounce(collision_info.get_normal())
		
