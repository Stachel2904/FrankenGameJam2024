extends Area2D

class_name Character

var _characterHealth : int = 100

var _attackDamage : int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Modifies current characterHealth and returns new characterHealth
func modifyHealth(healthModifier: int) -> int:
	_characterHealth += healthModifier
	if (_characterHealth < 0):
		_characterHealth = 0
	return _characterHealth

# Returns current characterHealth
func getCurrentHealth() -> int:
	return _characterHealth

# Set current characterHealth
func setHealth(newHealth : int) -> int:
	_characterHealth = newHealth
	return newHealth

# Returns current attackDamage
func getCurrentAttackDamage() -> int:
	return _attackDamage;

# Set current attackDamage
func setAttackDamage(newAttackDamage : int) -> int:
	_attackDamage = newAttackDamage
	return _attackDamage

# Modifies current attackDamage and returns new attackDamage
func modifyAttackDamage(attackDamageModifier: int) -> int:
	_attackDamage += attackDamageModifier
	return _attackDamage
