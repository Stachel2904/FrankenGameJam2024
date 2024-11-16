extends Node2D

@onready var _levelButtons = [
	$DJ_Console/Level_Btn1, 
	$DJ_Console/Level_Btn2, 
	$DJ_Console/Level_Btn3, 
	$DJ_Console/Level_Btn4, 
	$DJ_Console/Level_Btn5, 
	$DJ_Console/Level_Btn6
	]

@onready var _consoleRenderer : AnimatedSprite2D = $DJ_Console

func _ready() -> void:
	_refreshRenderStates()
	_consoleRenderer.play("idle")
	
func _process(delta: float) -> void:
	pass

func _isLevelUnlocked(index: int) -> bool:
	return true
	
func _refreshRenderStates() -> void:
	for i in _levelButtons.size():
		var currentLevelButton : Sprite2D = _levelButtons[i]
		if(_isLevelUnlocked(i)):
			currentLevelButton.modulate = Color(0,1,0)
		else:
			currentLevelButton.modulate = Color(1,0,0)
