extends RigidBody2D

@export var fap_strength: float = -450
@onready var sprite := $Sprite2D
var game_over := false

func _ready():
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
			gravity_scale = 1.75
			linear_velocity.y = fap_strength
	
func _integrate_forces(state):
	linear_velocity.x = 0

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("death"):
		get_tree().get_root().get_node("MainScene").end_game()
		game_over = true
