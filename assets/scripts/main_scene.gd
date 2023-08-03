extends Node2D
@onready var label = $Label
@onready var blockHold = $blockHolder
@onready var enemyHold = $enemyHolder
@onready var scoreHold = $scoreBlockHolder
@onready var spinHold = $spinBlockHolder
@onready var newHurtBlockTimer = $newHurtBlock
@onready var newCoinBlockTimer = $newCoinBlock
@onready var newSpinTimer = $newSpinBlock

var mouseX = null
var mouseY = null

var add : Node2D
var what = null

var blockNum = 0
var stringBlock = null
var block = "res://scenes/blocks/block.tscn"
var horizontalBlock ="res://scenes/blocks/horizontalBlock.tscn"
var verticalBlock = "res://scenes/blocks/verticalBlock.tscn"
var spinningBlock = "res://scenes/spinner.tscn"
var hurtBlock = "res://scenes/hazards/hurtBlock.tscn"
var coinBlock = "res://scenes/blocks/pointBlock.tscn"

var maxSpinHold = 1
var harmSpinBlock = "res://scenes/hazards/around_the_screen.tscn"
var pointSpinBlock #maybe later

func _ready():
	MusicController._play_song(1)
	Globals._reset()
	_spawn_hurt_block()
	_spawn_point_block()
	_spawn_spin_block()

func _process(delta):
	_mouse_position()
	_stop_song()#stops song at end
	if Globals.dead == false:
		_choosenBlock()
		_block_track()
		_maxHurtBlock()
		_increaseMaxSpinBlock()
		_pause()

func _increaseMaxSpinBlock():
	if Globals.score >= 200:
		maxSpinHold = 2

func _stop_song():
	if Globals.dead == false:
		pass
	else:
		MusicController._stop_music()

func _pause():
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true

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
	if OS.get_name() == "Windows" || OS.get_name() == "macOS":
		_controller(event, 1)
	if OS.get_name() == "Android" || OS.get_name() == "iOS":
		_controller(event, 2)

func _controller(event, whichOne):
	if whichOne == 1:
		if event.is_action_pressed("addClick") and add != null and Globals.dead == false:
			add._placed()
	if whichOne == 2:
		if event is InputEventMouseButton and event.double_click and add != null and Globals.dead == false:
			add._placed()

func _spawn_hurt_block():
	if Globals.dead == false:
		var rng2 = RandomNumberGenerator.new()
		var time = rng2.randi_range(1, 4)
		newHurtBlockTimer.wait_time = time
		newHurtBlockTimer.start()


func _on_new_hurt_block_timeout():
	if enemyHold.get_child_count() < Globals.maxHurtBlockCount:
		var block = load(hurtBlock)
		var where = block.instantiate()
		enemyHold.add_child(where)
	_spawn_hurt_block()
	

func _spawn_point_block():
	if Globals.dead == false:
		var rng2 = RandomNumberGenerator.new()
		var time = rng2.randi_range(1, 7)
		newCoinBlockTimer.wait_time = time
		newCoinBlockTimer.start()

func _on_new_coin_block_timeout():
	if scoreHold.get_child_count() < 2:
		var block = load(coinBlock)
		var where = block.instantiate()
		scoreHold.add_child(where)
	_spawn_point_block()

func _spawn_spin_block():
	if Globals.dead == false:
		var rng2 = RandomNumberGenerator.new()
		var time = rng2.randi_range(15, 25)#should be 15,25
		newSpinTimer.wait_time = time
		newSpinTimer.start()

func _on_new_spin_block_timeout():
	if spinHold.get_child_count() < maxSpinHold and Globals.score >= 85:
		var rng2 = RandomNumberGenerator.new()
		var pick = rng2.randi_range(1, 9)#add 10 for a speical point block
		var pickedBlock
		match [pick]:
			[1], [2], [3], [4], [5], [6], [7], [8], [9]:
				pickedBlock = harmSpinBlock
			[10]:
				pickedBlock = pointSpinBlock
		var block = load(pickedBlock)
		var where = block.instantiate()
		spinHold.add_child(where)
	_spawn_spin_block()

func _maxHurtBlock():#you may need to change these later _debug
	if Globals.score >= 35:
		Globals.maxHurtBlockCount = 4
	if Globals.score >=75:
		Globals.maxHurtBlockCount = 5
	if Globals.score >= 125:
		Globals.maxHurtBlockCount = 6

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

func _on_restart_button_pressed():
	get_tree().reload_current_scene()



