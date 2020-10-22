extends Node2D

var player_scene = load("res://player/Player.tscn")

var is_game_over := false

func _ready() -> void:
	connect("resized", self, "call_wrap_around")

func call_wrap_around():
	get_tree().call_group("wrap_around", "recalculate_wrap_area")


func _on_Player_player_died():
	$asteroidspawn/spawntime.stop()
	$Gameovertimer.start()


func _on_Gameovertimer_timeout():
	$Gameover.visible = true
	is_game_over = true

func _unhandled_input(event: InputEvent) -> void:
	if (is_game_over and event.is_action_released("restart_game")):
		_restart_game()

func _restart_game():
	_undo_game_over()
	_respawn_player()
	$asteroidspawn.restart()
	$GUI/MarginContainer/HBoxContainer/VBoxContainer/Score.reset()
	is_game_over = false

func _undo_game_over():
	$Gameover.visible = false

func _respawn_player():
	var player = player_scene.instance()
	player.position = Vector2(651, 645)
	add_child(player)
