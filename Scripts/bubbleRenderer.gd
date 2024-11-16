extends AnimatedSprite2D

@onready var _rhythm : float = 0.5
@onready var _maxCycleDuration : float = 20
@onready var _illuminationColors = [
	Color("FF0000"),
	Color("FFAA00"),
	Color("FEFF00"),
	Color("2BFF00"),
	Color("00FFD4"),
	Color("002AFF"),
	Color("AA00FF"),
	Color("FD00FF")
]

@onready var _selfCycleDuration : float
@onready var _isIlluminated : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(_selfCycleDuration <= 0 && _isIlluminated):
		_selfCycleDuration = _getNewDuration()
		self.modulate = Color(0,0,0)
		_isIlluminated = false
	elif(_selfCycleDuration <= 0 && !_isIlluminated):
		_selfCycleDuration = _rhythm
		var rng = RandomNumberGenerator.new()
		self.modulate = _illuminationColors[rng.randi_range(0, _illuminationColors.size() - 1)]
		_isIlluminated = true
	else:
		_selfCycleDuration -= delta

func _getNewDuration() -> float:
	var rng = RandomNumberGenerator.new()
	return rng.randf_range(1, _maxCycleDuration) * _rhythm
