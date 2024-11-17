extends Node2D

@onready var _levelButtons = [
	$CenterWrapper/DJ_Console/Level_Btn1, 
	$CenterWrapper/DJ_Console/Level_Btn2, 
	$CenterWrapper/DJ_Console/Level_Btn3, 
	$CenterWrapper/DJ_Console/Level_Btn4, 
	$CenterWrapper/DJ_Console/Level_Btn5, 
	$CenterWrapper/DJ_Console/Level_Btn6
	]
@onready var _levelStates = [
	$CenterWrapper/DJ_Console/Level_State1, 
	$CenterWrapper/DJ_Console/Level_State2, 
	$CenterWrapper/DJ_Console/Level_State3, 
	$CenterWrapper/DJ_Console/Level_State4, 
	$CenterWrapper/DJ_Console/Level_State5, 
	$CenterWrapper/DJ_Console/Level_State6
	]	
@onready var _levelCrowds = [
	$CenterWrapper/Background/Bubbles/Crowd1, 
	$CenterWrapper/Background/Bubbles/Crowd2, 
	$CenterWrapper/Background/Bubbles/Crowd3, 
	$CenterWrapper/Background/Bubbles/Crowd4, 
	$CenterWrapper/Background/Bubbles/Crowd5, 
	$CenterWrapper/Background/Bubbles/Crowd6
	]

var _unmutedPlaylist : Array = [
	"res://Assets/Music/HubSound/NDD1.mp3",
	"res://Assets/Music/HubSound/NDD2.mp3",
	"res://Assets/Music/HubSound/NDD3.mp3",
	"res://Assets/Music/HubSound/NDD4.mp3",
	"res://Assets/Music/HubSound/NDD5.mp3",
	"res://Assets/Music/HubSound/NDD6.mp3",
]

@onready var _consoleRenderer : AnimatedSprite2D = $CenterWrapper/DJ_Console
@onready var _backgroundRenderer : AnimatedSprite2D = $CenterWrapper/Background
@onready var _tentacle : Node2D = $CenterWrapper/DJ_Console/Tentacle
@onready var _exitBtn : Button = $CenterWrapper/Background/DjobClubDiscoball/Button2
@onready var _creditsBtn : Button = $Button
@onready var _creditsNode : Node2D = $Credits
@onready var _introNode : Node2D = $Intro
@onready var _endingNode : Node2D = $Ending

@onready var _hubMusic : AudioStreamPlayer = $HubMusic

@onready var seconds_array = [23, 18, 29, 26, 22, 33]
@onready var current_index = -1
@onready var _musicTimer : Timer = Timer.new()

@onready var _tentacleTarget : Vector2 = Vector2(0, 10)
@onready var _tentacleXPositions = [-15, -9, -3, 3, 9, 15]

func _ready() -> void:
	_refreshRenderStates()
	
	_exitBtn.pressed.connect(func() -> void : get_tree().quit(0))
	_creditsBtn.pressed.connect(func() -> void : _creditsNode.visible = true)
	
	#print(_hubMusic.get_stream_playback()._is_playing())
	
	add_child(_musicTimer)
	_musicTimer.connect("timeout", Callable(self, "_on_Timer_timeout"))
	start_next_timer()
	
	#print(_hubMusic.stream.get_list_stream(0))
	#print(_hubMusic.stream)
	
	for i in _levelButtons.size():
		var currentLevelButton : BaseButton = _levelButtons[i]
		currentLevelButton.mouse_entered.connect(func() -> void: _hoverLevel(i))
		currentLevelButton.mouse_exited.connect(func() -> void: _tentacleTarget = Vector2(0, 10))
		currentLevelButton.pressed.connect(func() -> void: _selectLevel(i))

func start_next_timer():
	_musicTimer.wait_time = seconds_array[current_index]
	_musicTimer.start()
	for i in _levelStates.size():
		_levelStates[i].modulate = Color(0,0,0)
	current_index = (current_index + 1) % seconds_array.size()
	_levelStates[current_index].modulate = Color(1,0.5,0)
	
	print("=======================" , current_index)

func _on_Timer_timeout():
	start_next_timer()

func _process(delta: float) -> void:
	if(_tentacle.position.distance_to(_tentacleTarget) > 1):
		_tentacle.translate((_tentacleTarget - _tentacle.position) * delta * 5)

func _isLevelUnlocked(index: int) -> bool:
	return Global.levelDict[Global.levelNames[index]]["Completed"]

func _refreshRenderStates() -> void:
	var allLevelCompleted : bool = true
	var noLevelCompleted : bool = true
	for i in _levelButtons.size():
		var currentLevelButton : TextureButton = _levelButtons[i]
		var currentLevelCrowd : CanvasItem = _levelCrowds[i]
		if(_isLevelUnlocked(i)):
			currentLevelButton.modulate = Color(0,1,0)
			currentLevelCrowd.visible = true
			
			_hubMusic.stop()
			var stream = ResourceLoader.load(_unmutedPlaylist[i])
			_hubMusic.stream.set_list_stream(i, stream)
			_hubMusic.play()
			
			noLevelCompleted = false
			
		else:
			currentLevelButton.modulate = Color(1,0,0)
			currentLevelCrowd.visible = false
			allLevelCompleted = false
	
	if(allLevelCompleted):
		_endingNode.visible = true
		
	_introNode.visible = noLevelCompleted

func _hoverLevel(level: int):	
	_tentacleTarget = Vector2(_tentacleXPositions[level], 10)
	
func _selectLevel(level: int):	
	_tentacleTarget = Vector2(_tentacleXPositions[level], 2)
	await get_tree().create_timer(0.5).timeout
	_changeLevel(level)
	
func _changeLevel(level: int):
	print("Level: ", level)
	Global.currentLevel = Global.levelNames[level]

	get_tree().change_scene_to_file("res://Level/TestVinnie.tscn")
