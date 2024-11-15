extends Area2D

var characterHealth : int = 100

var attackDamage : int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Modifies current characterHealth and returns new characterHealth
func modifyHealth(healthModifier: int) -> int:
	characterHealth += healthModifier
	if (characterHealth < 0):
		characterHealth = 0
	return characterHealth

# Returns current characterHealth
func getCurrentHealth() -> int:
	return characterHealth

# Set current characterHealth
func setHealth(newHealth : int) -> int:
	characterHealth = newHealth
	return newHealth

# Returns current attackDamage
func getCurrentAttackDamage() -> int:
	return attackDamage;

# Set current attackDamage
func setAttackDamage(newAttackDamage : int) -> int:
	attackDamage = newAttackDamage
	return attackDamage

# Modifies current attackDamage and returns new attackDamage
func modifyAttackDamage(attackDamageModifier: int) -> int:
	attackDamage += attackDamageModifier
	return attackDamage
