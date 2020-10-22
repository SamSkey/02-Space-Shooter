extends Node2D

var laserweapon := load("res://player/laserbeam.tscn")

func shoot():
	var laser = laserweapon.instance()
	laser.global_position = self.global_position
	get_node("/root/Game").add_child(laser)
