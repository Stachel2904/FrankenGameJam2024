extends Node2D

class_name BattleManager

@onready var player : Character = $Player
@onready var enemy : Character = $Enemy
@onready var battleNotes : BattleNotes = $CanvasLayer/BattlesNotes
@onready var classicDayText = "res://Assets/Music/Beat Map/Classic_Day.txt"


# Player Input Array for rhythm game aspect
var _playerBeat : Array = []
# ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]


var enemyBeat : Array = ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]

#@export var playerHP : int = 100
#@export var enemyHP : int = 100
#@export var playerDmg : int = -10
#@export var enemyDmg : int = -20

var _currentBeat : int = 0
var _noteSuccess : bool = false
var _isInBoomArea : bool = false

# Maximum length of beat matched to enemy beat
#var max_beat_length : int = enemyBeat.size()

# BEAT DINGSDABUNGSTA
#@export var beatTolerance : float = 0.2
@onready var beatSong : AudioStreamPlayer = $LevelMusic
# array of beats (in seconds)
#@export var beatTimings : Array[float] = [0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
#var bpm : int = 120
#var spb : float = 60.0 / bpm


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Enemy: ", enemyBeat)
	player.setHealth(Global.levelDict[Global.currentLevel]["PlayerHP"])
	enemy.setHealth(Global.levelDict[Global.currentLevel]["EnemyHP"])
	print("Player Health: ", player.getCurrentHealth())
	print("Enemy Health: ", enemy.getCurrentHealth())
	player.setAttackDamage(Global.levelDict[Global.currentLevel]["PlayerDMG"])
	enemy.setAttackDamage(Global.levelDict[Global.currentLevel]["EnemyDMG"])
	
	enemyBeat = _createNewEnemyBeat()
	battleNotes.initBattleNoteContainer(enemyBeat)

func _process(delta: float) -> void:
	_handleNoteInput()
	
	#if Input.is_action_just_pressed("ui_accept"):
		#_checkBeat()
	
	
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
#func _checkBeat():
	#if _playerBeat == enemyBeat:
		#print("PERFECT!")
		#enemy.modifyHealth(player.getCurrentAttackDamage())
	#else:
		#print("MISS")
		#player.modifyHealth(enemy.getCurrentAttackDamage())
	#print("Enemy Health: ", enemy.getCurrentHealth())
	#print("Player Health: ", player.getCurrentHealth())
	#
	#_resetBeat()

# reset player array
func _failBeat():
	if not _noteSuccess:
		battleNotes.resetStates("false")
		_playerBeat.clear()
		
func _resetBeat():
	enemyBeat = _createNewEnemyBeat()
	battleNotes.resetBattleNoteContainer(enemyBeat)
	_currentBeat = 0
	_noteSuccess = false
	_playerBeat.clear()
	

# TODO: checkBeatSlider - add good/nice/perfect if inside area2d, add miss if outside area2d
func checkBeatSlider():
	pass

func _compareBeatWithInput(input : String):
	if _playerBeat[_currentBeat] == input and _isInBoomArea:
		battleNotes.setNotesState(_currentBeat, "pressed")
		_currentBeat += 1
		if _currentBeat > enemyBeat.size() - 1:
			enemy.modifyHealth(player.getCurrentAttackDamage())
			_noteSuccess = true
			_resetBeat()
			print("YOU DID IT!")
			print("Enemy HP: ", enemy.getCurrentHealth())
		#print("Correct: ", _currentBeat)
	else:
		player.modifyHealth(enemy.getCurrentAttackDamage())
		_currentBeat = 0
		_failBeat()
		#print("False: ", _currentBeat)
		print("Player HP: ", player.getCurrentHealth())

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

#func read_beatmap(file_path):
	#var file = FileAccess.open(file_path, FileAccess.READ)
	#var content = file.get_as_text()
	#print(content)

func _on_boom_area_area_entered(area: Area2D) -> void:
	_isInBoomArea = true
	#print("It's inside me!")

func _on_boom_area_area_exited(area: Area2D) -> void:
	_isInBoomArea = false
	#print("It left me! sadge")
	
func _createNewEnemyBeat() -> Array:
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	return Global.enemyBeats[rand.randi_range(0, Global.enemyBeats.size() - 1)]
