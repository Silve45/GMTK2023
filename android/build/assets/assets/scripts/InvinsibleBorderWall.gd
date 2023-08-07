extends Node2D

var speed = 1000
var vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	vel = Vector2()
#	if Input.is_action_pressed("right"):
#		vel = Vector2(speed, 0)
#	if Input.is_action_pressed("left"):
#		vel = Vector2(-speed, 0)
#	if Input.is_action_pressed("down"):
#		vel = Vector2(0, speed)
#	if Input.is_action_pressed("up"):
#		vel = Vector2(0, -speed)
#
#
#	self.translate(vel * delta)
