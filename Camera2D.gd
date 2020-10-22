extends Camera2D

func _on_Player_laser_shoot():
	$shake.start(0.1, 15, 4, 0)
