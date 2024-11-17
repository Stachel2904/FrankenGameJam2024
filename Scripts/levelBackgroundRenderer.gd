extends Node
class_name LevelBackgroundRenderer

func ShowLevelBackgroundTextures(level: String) -> void:
	for child in self.get_children():
		var anim : AnimatedSprite2D = child
		anim.play(level)
