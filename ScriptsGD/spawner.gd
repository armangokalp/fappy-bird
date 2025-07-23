extends Node2D

@export var pipe_scene: PackedScene
@export var spawn_interval := 1.6
@export var pipe_x := 400.0
@export var pipe_min_y := -100.0
@export var pipe_max_y := 100.0

var gameOver

func _ready():
	gameOver = get_tree().get_root().get_node("MainScene").game_over
	start_spawning()

func start_spawning():
	if !gameOver:
		spawn_pipe()
		spawn_timer()

func spawn_timer():
	await get_tree().create_timer(spawn_interval).timeout
	start_spawning()

func spawn_pipe():
	var pipe = pipe_scene.instantiate()
	var y_offset = randf_range(pipe_min_y, pipe_max_y)
	pipe.position = Vector2(pipe_x, y_offset)
	add_child(pipe)
