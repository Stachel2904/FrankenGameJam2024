extends Control

class_name BattleNotes

@onready var _battleNoteContainer : HBoxContainer = $BattleNoteContainer
@onready var _arrowNoteUP = preload("res://Level/ArrowNoteUP.tscn")
@onready var _arrowNoteDOWN = preload("res://Level/ArrowNoteDOWN.tscn")
@onready var _arrowNoteLEFT = preload("res://Level/ArrowNoteLEFT.tscn")
@onready var _arrowNoteRIGHT = preload("res://Level/ArrowNoteRIGHT.tscn")


#var enemy_beat : Array = ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]

var arrowRotation : float = 90.0

var _battleNoteArray : Array = []
var number : int = 3

var _isInit : bool = false

var _isFalse : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#initBattleNoteContainer(enemy_beat)
	#print(_battleNoteArray)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func initBattleNoteContainer(enemyBeat : Array):
	for beat in enemyBeat:
		var instance
		match beat:
			"UP":
				instance = _arrowNoteUP.instantiate()
				print(beat)
			"DOWN":
				instance = _arrowNoteDOWN.instantiate()
				print(beat)
			"LEFT":
				instance = _arrowNoteLEFT.instantiate()
				print(beat)
			"RIGHT":
				instance = _arrowNoteRIGHT.instantiate()
				print(beat)
		
		_battleNoteArray.append(instance)
		_battleNoteContainer.add_child(instance)
	_isInit = true
	
func setNotesState(index : int, state : String):
	if _isInit:
		_battleNoteArray[index].setNoteState(state)

func resetStates(state : String):
	if _isInit:
		for note in _battleNoteArray:
			note.setNoteState(state)
		if state == "false":
			_isFalse = true

func getIsFalse() -> bool:
	return _isFalse

func resetIsFalse():
	_isFalse = false
