extends Control

class_name ArrowNote

@onready var text : TextureRect = $TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#rotateArrowNote(90.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func rotateArrowNote(degrees : float):
	text.set_rotation_degrees(degrees)
