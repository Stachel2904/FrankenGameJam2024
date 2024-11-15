extends Area2D

# Default health value, DO NOT MODIFY IN CODE
@export var health = 100
var characterHealth

@export var attackDamage = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	characterHealth = health
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

# Resets characterHealth to default health value
func resetHealth():
	characterHealth = health

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
