extends Node

var enemyBeats = [
	["UP", "DOWN", "LEFT", "RIGHT"],
	["LEFT", "RIGHT", "UP", "UP", "DOWN"],
	["DOWN", "DOWN", "LEFT", "UP", "RIGHT", "LEFT"],
	["RIGHT", "UP", "UP", "LEFT", "DOWN", "DOWN", "LEFT"],
	["UP", "RIGHT", "LEFT", "DOWN", "UP", "UP", "RIGHT", "LEFT"],
	["DOWN", "UP", "DOWN", "LEFT", "RIGHT", "LEFT", "UP", "RIGHT"],
	["UP", "UP", "DOWN", "LEFT", "RIGHT", "UP", "DOWN", "LEFT", "RIGHT"],
	["RIGHT", "LEFT", "UP", "DOWN", "UP", "LEFT", "DOWN", "UP", "RIGHT"],
	["LEFT", "DOWN", "UP", "RIGHT", "LEFT", "RIGHT", "UP", "DOWN", "DOWN", "UP"],
	["DOWN", "RIGHT", "UP", "UP", "DOWN", "LEFT", "UP", "RIGHT", "LEFT", "DOWN"],
	["RIGHT", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "LEFT", "UP", "DOWN", "UP"],
	["DOWN", "LEFT", "RIGHT", "UP", "UP", "DOWN", "LEFT", "RIGHT", "UP", "DOWN"],
	["UP", "LEFT", "DOWN", "RIGHT", "UP", "DOWN", "LEFT", "UP"],
	["RIGHT", "UP", "DOWN", "LEFT", "RIGHT", "LEFT", "DOWN", "UP"],
	["DOWN", "RIGHT", "UP", "LEFT", "DOWN", "UP", "LEFT"],
	["UP", "LEFT", "RIGHT", "DOWN", "LEFT", "DOWN", "UP", "RIGHT", "UP"],
	["DOWN", "LEFT", "UP", "RIGHT", "DOWN", "LEFT", "RIGHT", "UP"],
	["UP", "DOWN", "RIGHT", "LEFT", "UP", "UP", "LEFT", "DOWN", "RIGHT", "UP"],
	["LEFT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN"],
	["UP", "LEFT", "DOWN", "RIGHT", "UP", "DOWN", "RIGHT", "UP", "LEFT"],
	["DOWN", "RIGHT", "LEFT", "UP", "DOWN", "LEFT", "RIGHT"],
	["UP", "UP", "DOWN", "LEFT", "RIGHT", "LEFT", "UP", "DOWN", "RIGHT"],
	["DOWN", "UP", "RIGHT", "LEFT", "UP", "DOWN", "RIGHT"],
	["LEFT", "RIGHT", "UP", "DOWN", "UP", "LEFT", "DOWN", "RIGHT"],
	["UP", "DOWN", "LEFT", "RIGHT", "UP", "UP", "DOWN", "LEFT"],
	["DOWN", "LEFT", "UP", "RIGHT", "DOWN", "UP", "DOWN", "RIGHT", "LEFT"],
	["LEFT", "RIGHT", "DOWN", "UP", "LEFT", "UP", "DOWN", "RIGHT"],
	["DOWN", "UP", "LEFT", "RIGHT", "UP", "DOWN"],
	["UP", "LEFT", "RIGHT", "DOWN", "UP", "DOWN", "LEFT", "UP", "DOWN"],
	["RIGHT", "LEFT", "UP", "DOWN", "UP", "LEFT", "DOWN", "UP"],
	["LEFT", "DOWN", "UP", "DOWN", "RIGHT", "UP", "LEFT", "DOWN"],
	["DOWN", "UP", "DOWN", "LEFT", "RIGHT", "LEFT", "UP"],
	["UP", "DOWN", "LEFT", "RIGHT", "UP", "DOWN", "RIGHT", "UP", "DOWN"],
	["LEFT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "RIGHT", "UP"],
	["DOWN", "LEFT", "UP", "RIGHT", "DOWN", "UP", "LEFT", "DOWN"],
	["UP", "LEFT", "DOWN", "UP", "RIGHT", "LEFT", "DOWN", "UP"],
	["RIGHT", "DOWN", "LEFT", "UP", "DOWN", "UP", "LEFT"],
	["DOWN", "RIGHT", "UP", "LEFT", "RIGHT", "DOWN", "UP"],
	["LEFT", "UP", "DOWN", "RIGHT", "DOWN", "LEFT"]
]

var currentLevel = "One"


var levelDict = {
		"One" : {
			"Name": "Level 1", 
			"Music": ["res://Assets/Music/Video_Game_Morning.ogg", "res://Assets/Music/Video_Game_Day.ogg",  "res://Assets/Music/Video_Game_Night.ogg"],
			"BPM": 116,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -50,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		},
		"Two" : {
			"Name": "Level 2", 
			"Music": ["res://Assets/Music/Metal_Synth_Morning.ogg", "res://Assets/Music/Metal_Synth_Day.ogg",  "res://Assets/Music/Metal_Synth_Night.ogg"], 
			"BPM": 127,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -10,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		},
		"Three" : {
			"Name": "Level 3", 
			"Music": ["res://Assets/Music/Tropical_House_Morning.ogg", "res://Assets/Music/Tropical_House_Day.ogg",  "res://Assets/Music/Tropical_House_Night.ogg"], 
			"BPM": 128,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -10,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		},
		"Four" : {
			"Name": "Level 4", 
			"Music": ["res://Assets/Music/Electronic_Morning.ogg", "res://Assets/Music/Electronic_Day.ogg",  "res://Assets/Music/Electronic_Night.ogg"], 
			"BPM": 123,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -10,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		},
		"Five" : {
			"Name": "Level 5", 
			"Music": ["res://Assets/Music/Classic_Morning.ogg", "res://Assets/Music/Classic_Day.ogg",  "res://Assets/Music/Classic_Night.ogg"], 
			"BPM": 130,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -10,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		},
		"Six" : {
			"Name": "Level 6", 
			"Music": ["res://Assets/Music/Jazzy_Hiphop_Morning.ogg", "res://Assets/Music/Jazzy_Hiphop_Day.ogg",  "res://Assets/Music/Jazzy_Hiphop_Night.ogg"], 
			"BPM": 125,
			"PlayerHP": 100,
			"EnemyHP": 100,
			"PlayerDMG": -10,
			"EnemyDMG": [-5, -10, -15],
			"Completed": false,
			"Background": 0,
			"EnemyScale": [1, 2, 3]
		}
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
