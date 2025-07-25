extends Button

var paused := false


func _on_toggled(toggled_on: bool) -> void:
	if !paused:
		Engine.time_scale = 0
		paused = true
	else:
		Engine.time_scale = 1
		paused = false
