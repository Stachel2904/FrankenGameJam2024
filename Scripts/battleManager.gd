extends Node2D

class_name BattleManager

@onready var player : Character = $Player
@onready var enemy : Character = $Enemy
@onready var battleNotes : BattleNotes = $CanvasLayer/BattlesNotes


# Player Input Array for rhythm game aspect
var _playerBeat : Array = []
# ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]
@export var enemyBeat : Array = ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]

@export var playerHP : int = 100
@export var enemyHP : int = 100
@export var playerDmg : int = -10
@export var enemyDmg : int = -20

var _currentBeat : int = 0
var _noteSuccess : bool = false

# Maximum length of beat matched to enemy beat
var max_beat_length : int = enemyBeat.size()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Enemy: ", enemyBeat)
	player.setHealth(playerHP)
	enemy.setHealth(enemyHP)
	print("Player Health: ", player.getCurrentHealth())
	print("Enemy Health: ", enemy.getCurrentHealth())
	player.setAttackDamage(playerDmg)
	enemy.setAttackDamage(enemyDmg)
	battleNotes.initBattleNoteContainer(enemyBeat)

func _process(delta: float) -> void:
	_handleNoteInput()
	
	if Input.is_action_just_pressed("ui_accept"):
		_checkBeat()
	
	
# add input to array
# TODO: Make it visual like HellDivers2, White Arrows become highlighted for each correct beat press
func _addToBeat(action: String):
	if _playerBeat.size() < enemyBeat.size():
		_playerBeat.append(action)
		print("Appended Button: ", action)
		print("Player Beat Array: ", _playerBeat)

# check if array matches enemy array
func _checkNote():
	if battleNotes.getIsFalse():
		battleNotes.resetIsFalse()
		battleNotes.resetStates("default")
	
	if not _playerBeat.is_empty():
		match enemyBeat[_currentBeat]:
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
	if _playerBeat == enemyBeat:
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
	if not _noteSuccess:
		battleNotes.resetStates("false")
		_playerBeat.clear()

# TODO: checkBeatSlider - add good/nice/perfect if inside area2d, add miss if outside area2d
func checkBeatSlider():
	pass

func _compareBeatWithInput(input : String):
	if _playerBeat[_currentBeat] == input:
		battleNotes.setNotesState(_currentBeat, "pressed")
		_currentBeat += 1
		if _currentBeat > enemyBeat.size() - 1:
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
