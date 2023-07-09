extends Node2D
@onready var timer = $Timer
@onready var collisionShape = $StaticBody2D/CollisionShape2D
@onready var canPlaceArea = $canPlaceArea
@onready var SFX = $AudioStreamPlayer

var placed = false
var mouseX = null
var mouseY = null
var canPlace

func _ready(): 
	_not_placed()
	SFX.volume_db = -10

func _despawn():
	queue_free()

func _on_timer_timeout():
	_despawn()

func _not_placed():
	$".".modulate = "639bff7d"
	collisionShape.disabled = true
	placed = false

func _process(delta):
	_mouse_position()
	_block_mouse()
	_canPlace()
	canPlace = canPlaceArea.has_overlapping_bodies()# || canPlaceArea.has_overlapping_areas()


func _mouse_position():
	mouseX = get_viewport().get_mouse_position().x
	mouseY = get_viewport().get_mouse_position().y

func _block_mouse():
	if placed == false:
		position.x = mouseX
		position.y = mouseY

func _placed():
	if canPlace == false and placed == false and Globals.dead == false:
		var sound = load("res://assets/soundEffects/ballHitOffBlock.wav")
		SFX.stream = sound
		SFX.play()
		$".".modulate = "639bff"
		collisionShape.disabled = false
		timer.start()
		placed = true

func _canPlace():
	if canPlace == false and placed == false:
		$".".modulate = "639bff7d"
	if canPlace == true and placed == false:
		$".".modulate = "d151ee67"


