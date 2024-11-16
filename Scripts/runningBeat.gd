extends Area2D

var speed : float = 300.0
@export var time : float = 0.46875/2

var destination : int

@onready var Ypos = get_viewport().size.y * 0.85
@onready var BXpos = get_viewport().size.x * 0.5
@onready var AXpos = get_viewport().size.x * 0.1
@onready var CXpos = get_viewport().size.x * 0.9  

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	##var screenSize = DisplayServer.screen_get_size()
	#var gameSize = get_viewport().size
	#destination = gameSize.x / 2
	#speed = destination / time
	##print(screenSize)
	#print(gameSize)
	#print("Distance: ", destination)
	#print("Speed: ", speed)
	#
	#position.x = -64
	#position.y = gameSize.y * 0.85
	##print(position)
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	##position.x += speed
	#position += transform.x * speed * delta
	#pass

# Define points A, B, and C
@onready var point_a = Vector2(AXpos, Ypos)
@onready var point_b = Vector2(BXpos, Ypos)
@onready var point_c = Vector2(CXpos, Ypos)

# Define time frames for each movement
var time_to_a = time
var time_to_b_from_a = time
var time_to_c = time
var time_to_b_from_c = time

## Store the current time and target point
#var current_time = 0.0
#var target_point = point_b

var tween: Tween

func _ready() -> void:
	position = Vector2(BXpos, Ypos)
	print(position)
	move_to(point_a, time_to_a, "_on_reach_point_a")
	
func move_to(target: Vector2, duration: float, callback: String) -> void:
	# Create new tween for movement
	var tween = create_tween()
	tween.tween_property(self, "position", target, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	tween.tween_callback(Callable(self,callback))
	
func _on_reach_point_a() -> void:
	move_to(point_b, time_to_b_from_a, "_on_reach_point_b_from_a")
	
func _on_reach_point_b_from_a() -> void:
	move_to(point_c, time_to_c, "_on_reach_point_c")
	
func _on_reach_point_c() -> void:
	move_to(point_b, time_to_b_from_c, "_on_reach_point_b_from_c")
	
func _on_reach_point_b_from_c() -> void:
	move_to(point_a, time_to_a, "_on_reach_point_a")
