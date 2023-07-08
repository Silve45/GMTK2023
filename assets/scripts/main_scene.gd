extends Node2D
@onready var label = $Label
@onready var blockHold = $blockHolder
@onready var enemyHold = $enemyHolder
@onready var scoreBlock = $scoreBlockHolder
@onready var newHurtBlockTimer = $newHurtBlock
@onready var newCoinBlockTimer = $newCoinBlock

var mouseX = null
var mouseY = null

var add : Node2D
var what = null

var maxHurtBlockCount = 3
var blockNum = 0
var stringBlock = null
var block = "res://scenes/blocks/block.tscn"
var horizontalBlock ="res://scenes/blocks/horizontalBlock.tscn"
var verticalBlock = "res://scenes/blocks/verticalBlock.tscn"
var spinningBlock = "res://scenes/spinner.tscn"
var hurtBlock = "res://scenes/hazards/hurtBlock.tscn"

func _ready():
	_spawn_hurt_block()

func _process(delta):
	#begin mouse stuff
	_mouse_position()
	var mouseLocation = str(mouseX, ": ", mouseY)
	label.set_text(mouseLocation)
	#end mouse stuff
	
	_choosenBlock()
	_block_track()
	_maxHurtBlock()

func _choosenBlock():
	match[blockNum]:
		[0]:
			stringBlock = block
		[1]:
			stringBlock = horizontalBlock
		[2]:
			stringBlock = verticalBlock
	return stringBlock

func _block_track():
	if blockHold.get_child_count() < 1:
		what = load(stringBlock)
		add = what.instantiate()
		add.position = Vector2(mouseX,mouseY)
		blockHold.add_child(add)
		_increment_block()


func _input(event):
	if event.is_action_pressed("addClick") and add != null:
		add._placed()
		


func _spawn_hurt_block():
	var rng2 = RandomNumberGenerator.new()
	var time = rng2.randi_range(1, 4)
	newHurtBlockTimer.wait_time = time
	newHurtBlockTimer.start()


func _on_new_hurt_block_timeout():
	if enemyHold.get_child_count() < maxHurtBlockCount:
		var block = load(hurtBlock)
		var where = block.instantiate()
		enemyHold.add_child(where)
	_spawn_hurt_block()

func _maxHurtBlock():#you may need to change these later _debug
	if Globals.score >= 35:
		maxHurtBlockCount = 4
	if Globals.score >=75:
		maxHurtBlockCount = 5
	if Globals.score >= 125:
		maxHurtBlockCount = 6
	



func _increment_block():
	var click = true
	if blockNum == 0 and click == true:
		click = false
		blockNum = 1
	if blockNum == 1 and click == true:
		click = false
		blockNum = 2
	if blockNum == 2 and click == true:
		click = false
		blockNum = 0

func _mouse_position():
	mouseX = get_viewport().get_mouse_position().x
	mouseY = get_viewport().get_mouse_position().y



