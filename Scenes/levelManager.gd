extends Control

@export var game_over := false
var aniPlayer
var score := 0
@onready var score_label = $UI/ScoreLabel

func _ready():
	aniPlayer = $UI/FlashMesh/AnimationPlayer
	
func _process(delta):
	if Engine.time_scale == 0.0:
		print("Game paused")
	
	score_label.text = "[center][b][font_size=48][color=red]" + str(score) + "[/color][/font_size][/b][/center]"
		
func inc_score() -> int:
	score += 1
	return score

func get_score() -> int:
	return score

func end_game() -> bool:
	if !game_over:
		game_over = true
		death_animation()
		print("GAME OVER!")
	return true

func death_animation():
	aniPlayer.play("flash_animation")
