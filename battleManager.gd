extends Node2D

# Player Input Array for rhythm game aspect
var player_beat : Array = []

# TESTING: Target Sequence as example to test Gameplay
# TODO: get enemy beat from enemy
# ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT", "B", "A"]
var enemy_beat : Array = ["UP","UP", "DOWN", "DOWN", "LEFT", "RIGHT", "LEFT", "RIGHT"]

# Maximum length of beat matched to enemy beat
var max_beat_length : int = enemy_beat.size()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Enemy: ", enemy_beat)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		addToBeat("UP")
	elif  Input.is_action_just_pressed("ui_down"):
		addToBeat("DOWN")
	elif Input.is_action_just_pressed("ui_left"):
		addToBeat("LEFT")
	elif Input.is_action_just_pressed("ui_right"):
		addToBeat("RIGHT")
	elif Input.is_action_just_pressed("ui_accept"):
		checkBeat()

# add input to array
# TODO: Make it visual like HellDivers2, White Arrows become highlighted for each correct beat press
func addToBeat(action: String):
	if player_beat.size() < enemy_beat.size():
		player_beat.append(action)
		print(action)

# check if array matches enemy array
# TODO: check if it matches with BeatSlider
func checkBeat():
	print("Player: ", player_beat)
	if player_beat == enemy_beat:
		print("PERFECT!")
	else:
		print("MISS")
	resetBeat()
		
# reset player array
func resetBeat():
	player_beat.clear()

# TODO: checkBeatSlider - add good/nice/perfect if inside area2d, add miss if outside area2d
func checkBeatSlider():
	pass
