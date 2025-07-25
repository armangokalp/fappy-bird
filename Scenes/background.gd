extends Node2D

@export var speed: float = 12.0

@onready var sprite1: Sprite2D = $Background1
@onready var sprite2: Sprite2D = $Background2

var sprite_width: float = 0.0
var off_screen_threshold: float = 0.0
var mainScene

func _ready():
	mainScene = get_tree().get_root().get_node("MainScene")
	
	var initial_pos1 = sprite1.position.x
	var initial_pos2 = sprite2.position.x
	
	sprite_width = abs(initial_pos2 - initial_pos1)
	
	off_screen_threshold = initial_pos1 - sprite_width

func _process(delta):
	if !mainScene.game_over:
		var move_amount = speed * delta
		sprite1.position.x -= move_amount
		sprite2.position.x -= move_amount
		
		if sprite1.position.x <= off_screen_threshold:
			sprite1.position.x = sprite2.position.x + sprite_width
		
		if sprite2.position.x <= off_screen_threshold:
			sprite2.position.x = sprite1.position.x + sprite_width
			
		position.x = round(position.x)
