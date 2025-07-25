extends RigidBody2D

@export var fap_strength: float = -900
@onready var sprite := $Sprite2D
var game_over := false
var jump_sound
var death_sound
var can_restart := false

func _ready():
	jump_sound = $Jump
	death_sound = $death
	print("Start")
	
func _process(delta):

	var tilt := 0.0

	if linear_velocity.y < 0:
		sprite.rotation_degrees = -30
	elif linear_velocity.y > 100 || (linear_velocity.y >= 0 && game_over):
		tilt = 90
	else:
		tilt = 0

	sprite.rotation_degrees = lerp(sprite.rotation_degrees, tilt, 5 * delta)
	

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if !game_over:
			gravity_scale = 3.5
			linear_velocity.y = fap_strength
			jump_sound.pitch_scale = randf_range(0.95, 1.05)
			jump_sound.play()
		elif can_restart:
			get_tree().reload_current_scene()
			
func _unhandled_input(event):
	if event.is_pressed():
		if OS.get_name() == "Web":
			print("Running on HTML5")
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)
			print("Audio unmuted on user interaction (HTML5 fix)")

			
	
func _integrate_forces(state):
	linear_velocity.x = 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("death"):
		get_tree().get_root().get_node("MainScene").end_game()
		if !death_sound.playing:
			death_sound.play()
			
		game_over = true
		_can_restart()
		
func _can_restart():
	var timer = Timer.new()
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.timeout.connect(_var_true)
	add_child(timer)
	timer.start()
	
func _var_true():
	can_restart = true
