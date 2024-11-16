extends Node2D

class_name BattleManager

# Player Input Array for rhythm game aspect
var _playerBeat : Array = []

# TESTING: Target Sequence as example to test Gameplay
# TODO: get enemy beat from enemy
# ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]
var _enemyBeat : Array = ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]
#var enemy_dmg : int = -10

# Maximum length of beat matched to enemy beat
var max_beat_length : int = _enemyBeat.size()

@onready var player : Character = $Player
@onready var enemy : Character = $Enemy
@onready var battleNotes : BattleNotes = $CanvasLayer/BattlesNotes

@export var playerHP : int = 100
@export var enemyHP : int = 100
@export var playerDmg : int = -10
@export var enemyDmg : int = -20

var _currentBeat : int = 0
var _noteSuccess : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Enemy: ", _enemyBeat)
	player.setHealth(playerHP)
	enemy.setHealth(enemyHP)
	print("Player Health: ", player.getCurrentHealth())
	print("Enemy Health: ", enemy.getCurrentHealth())
	player.setAttackDamage(playerDmg)
	enemy.setAttackDamage(enemyDmg)
	battleNotes.initBattleNoteContainer(_enemyBeat)

func _process(delta: float) -> void:
	_handleNoteInput()
	
	if Input.is_action_just_pressed("ui_accept"):
		_checkBeat()
	
	
# add input to array
# TODO: Make it visual like HellDivers2, White Arrows become highlighted for each correct beat press
func _addToBeat(action: String):
	if _playerBeat.size() < _enemyBeat.size():
		_playerBeat.append(action)
		print("Appended Button: ", action)
		print("Player Beat Array: ", _playerBeat)

# check if array matches enemy array
func _checkNote():
	var array_size = _enemyBeat.size()
	if not _playerBeat.is_empty():
		match _enemyBeat[_currentBeat]:
			"UP":
				_compareBeatWithInput("UP")
			"DOWN":
				_compareBeatWithInput("DOWN")
			"LEFT":
				_compareBeatWithInput("LEFT")
			"RIGHT":
				_compareBeatWithInput("RIGHT")
	
	print("Player: ", _playerBeat)
	
# TODO: check if it matches with BeatSlider
func _checkBeat():
	if _playerBeat == _enemyBeat:
		print("PERFECT!")
		enemy.modifyHealth(player.getCurrentAttackDamage())
	else:
		print("MISS")
		player.modifyHealth(enemy.getCurrentAttackDamage())
	print("Enemy Health: ", enemy.getCurrentHealth())
	print("Player Health: ", player.getCurrentHealth())
	
	_resetBeat()

# reset player array
func _resetBeat():
	_playerBeat.clear()

# TODO: checkBeatSlider - add good/nice/perfect if inside area2d, add miss if outside area2d
func checkBeatSlider():
	pass

func _compareBeatWithInput(input : String):
	if _playerBeat[_currentBeat] == input:
		_currentBeat += 1
		if _currentBeat > _enemyBeat.size() - 1:
			_noteSuccess = true
			print("YOU DID IT!")
		print("Correct: ", _currentBeat)
	else:
		_currentBeat = 0
		_resetBeat()
		print("False: ", _currentBeat)

func _handleNoteInput():
	if not _noteSuccess:
		if Input.is_action_just_pressed("ui_up"):
			_addToBeat("UP")
			_checkNote()
		elif  Input.is_action_just_pressed("ui_down"):
			_addToBeat("DOWN")
			_checkNote()
		elif Input.is_action_just_pressed("ui_left"):
			_addToBeat("LEFT")
			_checkNote()
		elif Input.is_action_just_pressed("ui_right"):
			_addToBeat("RIGHT")
			_checkNote()
