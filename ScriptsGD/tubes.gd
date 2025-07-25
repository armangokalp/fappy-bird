extends Node2D

@export var speed := 120.0
var tube_size
var mainScene
var score_sound

func _ready():
	mainScene = get_tree().get_root().get_node("MainScene")
	score_sound = $inc_score
	
	var top_sprite = $Top/Sprite2D
	var bottom_sprite = $Bottom/Sprite2D

	var top_size = top_sprite.texture.get_size().x if top_sprite.texture != null else 128
	var bottom_size = bottom_sprite.texture.get_size().x if bottom_sprite.texture != null else 128
	
	tube_size = top_size if top_size == bottom_size else 128

func _process(delta):
	if !mainScene.game_over:
		position.x -= speed * delta
	elif score_sound.playing:
		score_sound.stop()
	
	destroy_pipe()


func destroy_pipe():
	if position.x < -tube_size:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") && !mainScene.game_over:
		mainScene.inc_score()
		score_sound.play()
