extends CharacterBody2D

@export var speed = 200
var vel = Vector2()
var canMove = true
var minSpeed = speed

func _ready():
	pass

func _process(delta):
	print(vel)


func _physics_process(delta):
	if canMove == true:
		vel = Vector2()
		if Input.is_action_pressed("right"):
			vel = Vector2(speed, 0)
		if Input.is_action_pressed("left"):
			vel = Vector2(-speed, 0)
		if Input.is_action_pressed("down"):
			vel = Vector2(0, speed)
		if Input.is_action_pressed("up"):
			vel = Vector2(0, -speed)

		if abs(speed) <= minSpeed:
			speed = minSpeed

		move_and_collide(vel * delta)

