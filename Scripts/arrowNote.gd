extends Control

@onready var anim = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#rotateArrowNote(90.0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func rotateArrowNote(degrees : float):
	#text.set_rotation_degrees(degrees)

func setNoteState(state : String):
	match state:
		"default":
			anim.play("default")
		"false":
			anim.play("false")
		"pressed":
			anim.play("pressed")
