extends "res://asteroids/Asteroid.gd"

func _ready():
	score_value = 250

func explode():
	if is_explode:
		return
	is_explode = true
	emit_signal("score_changed", score_value)
	get_parent().remove_child(self)
	queue_free()
