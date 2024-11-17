extends Node2D

@onready var btn : Button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn.pressed.connect(func() -> void: self.visible = false)
