extends Node

var asteroids = load("res://asteroids/Asteroid.tscn")

func _ready():
	_spawn_asteroid()

func _spawn_asteroid():
	var asteroid = asteroids.instance()
	_set_asteroid_position(asteroid)
	add_child(asteroid)
	_set_asteroid_fling(asteroid)

func _set_asteroid_position(asteroid):
	var rect = get_viewport().size
	asteroid.position = Vector2(rand_range(0, rect.x), -100)

func _set_asteroid_fling(asteroid):
	asteroid.angular_velocity = rand_range(-4,4)
	asteroid.angular_damp = 0
	asteroid.linear_velocity = Vector2(rand_range(-300, 300), 300)
	asteroid.linear_damp = 0

func _on_spawntime_timeout():
	_spawn_asteroid()

func restart():
	$spawntime.stop()
	$spawntime.start()
