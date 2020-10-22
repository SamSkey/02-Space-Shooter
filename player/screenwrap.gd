extends Node

export (Rect2) var wrapArea = null
export (bool) var horizontalWrapping = true
export (bool) var verticalWrapping = true

var Axis = {
	Horizontal = "x",
	Vertical = "y"
}

func initWrapArea():
	if wrapArea == null:
		wrapArea = Rect2(Vector2(), get_viewport().size)

func recalculate_wrap_area():
	wrapArea = Rect2(Vector2(), get_viewport().size)

func _ready():
	initWrapArea()
	add_to_group("wrap_around")

func _process(delta):
	if !wrapArea.has_point(get_parent().global_position):
		wrap()

func wrap():
	if horizontalWrapping:
		wrapBy(Axis.Horizontal)
	if verticalWrapping:
		wrapBy(Axis.Vertical)

func getAxisWrapDirection(axis):
	if get_parent().global_position[axis] < wrapArea.position[axis]:
		return 1
	elif get_parent().global_position[axis] > wrapArea.size[axis]:
		return -1
	return 0

func wrapBy(axis):
	var adjust = getAxisWrapDirection(axis) * wrapArea.size[axis]
	get_parent().position[axis] += adjust
