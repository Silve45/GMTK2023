extends Node2D

@export var speed = 1 

@onready var timer = $Timer

func _despawn():
	queue_free()

func _ready(): 
	timer.start()

func _on_timer_timeout():
	_despawn()

func _process(delta):
	_spin(delta)

func _spin(delta):
	rotation += speed * delta
