extends Node

func _ready() -> void:
	ShowLevelBackgroundTextures(RandomNumberGenerator.new().randi_range(0,5))

func ShowLevelBackgroundTextures(level: int) -> void:
	for child in self.get_children():
		var anim : AnimatedSprite2D = child
		anim.play(str(level))
