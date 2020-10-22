extends RigidBody2D

var asteroid_2 := load("res://asteroids/Asteroid2.tscn")
var randomfling := RandomNumberGenerator.new()

var is_explode := false

signal score_changed
var score_value = 100

func _ready():
	var label = get_tree().get_root().get_node("Game/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")
	
func explode():
	if is_explode:
		return
	is_explode = true
	emit_signal("score_changed", score_value)
	_spawn_asteroid2more(4)
	get_parent().remove_child(self)
	queue_free()

func _spawn_asteroid2more(num: int):
	for i in range(num):
		_spawn_asteroid2()

func _spawn_asteroid2():
	var asteroid2 = asteroid_2.instance()
	asteroid2.position = self.position
	_random_fling(asteroid2)
	get_parent().add_child(asteroid2)

func _random_fling(asteroid):
	asteroid.angular_velocity = rand_range(-4, 4)
	asteroid.angular_damp = 0
	randomfling.randomize()
	var linearx = randomfling.randi_range(-1, 1)
	var lineary = randomfling.randi_range(-1, 1)
	asteroid.linear_velocity = Vector2(linearx * 300, lineary * 300)
	asteroid.linear_damp = 0

func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
