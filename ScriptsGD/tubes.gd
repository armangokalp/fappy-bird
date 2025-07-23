extends Node2D

@export var speed := 120.0
var tube_size
var mainScene

func _ready():
	mainScene = get_tree().get_root().get_node("MainScene")
		
	var top_sprite = $Top/Sprite2D
	var bottom_sprite = $Bottom/Sprite2D

	var top_size = top_sprite.texture.get_size().x if top_sprite.texture != null else 128
	var bottom_size = bottom_sprite.texture.get_size().x if bottom_sprite.texture != null else 128
	
	tube_size = top_size if top_size == bottom_size else 128

func _process(delta):
	if !mainScene.game_over:
		position.x -= speed * delta
	
	destroy_pipe()


func destroy_pipe():
	if position.x < -tube_size:
		queue_free()
