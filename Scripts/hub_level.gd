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

@onready var _consoleRenderer : AnimatedSprite2D = $CenterWrapper/DJ_Console
@onready var _backgroundRenderer : AnimatedSprite2D = $CenterWrapper/Background
@onready var _tentacle : Node2D = $CenterWrapper/DJ_Console/Tentacle

@onready var _tentacleTarget : Vector2 = Vector2(0, 10)
@onready var _tentacleXPositions = [-15, -9, -3, 3, 9, 15]

func _ready() -> void:
	_refreshRenderStates()
	
	for i in _levelButtons.size():
		var currentLevelButton : BaseButton = _levelButtons[i]
		currentLevelButton.mouse_entered.connect(func() -> void: _hoverLevel(i))
		currentLevelButton.mouse_exited.connect(func() -> void: _tentacleTarget = Vector2(0, 10))
		currentLevelButton.pressed.connect(func() -> void: _selectLevel(i))
	
func _process(delta: float) -> void:
	if(_tentacle.position.distance_to(_tentacleTarget) > 1):
		_tentacle.translate((_tentacleTarget - _tentacle.position) * delta * 5)
	pass

func _isLevelUnlocked(index: int) -> bool:
	return true

func _refreshRenderStates() -> void:
	for i in _levelButtons.size():
		var currentLevelButton : TextureButton = _levelButtons[i]
		var currentLevelState : Sprite2D = _levelStates[i]
		var currentLevelCrowd : CanvasItem = _levelCrowds[i]
		if(_isLevelUnlocked(i)):
			currentLevelButton.modulate = Color(0,1,0)
			currentLevelState.modulate = Color(0,1,0)
			currentLevelCrowd.visible = true
		else:
			currentLevelButton.modulate = Color(1,0,0)
			currentLevelState.modulate = Color(1,0,0)
			currentLevelCrowd.visible = false

func _hoverLevel(level: int):	
	_tentacleTarget = Vector2(_tentacleXPositions[level], 10)
	
func _selectLevel(level: int):	
	_tentacleTarget = Vector2(_tentacleXPositions[level], 2)
