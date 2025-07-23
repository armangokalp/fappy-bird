extends Control

@export var game_over := false
var aniPlayer

func _ready():
	aniPlayer = $UI/FlashMesh/AnimationPlayer
	
func _process(delta):
	if Engine.time_scale == 0.0:
		print("Game paused")

func end_game() -> bool:
	if !game_over:
		game_over = true
		death_animation()
		print("GAME OVER!")
	return true

func death_animation():
	aniPlayer.play("flash_animation")
