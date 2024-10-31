extends Node2D

var cells_amt = 300.0
@onready var cell_width = 1000.0 / cells_amt
var cells = []
var amt_moved = 0.0

func _ready():
	for i in cells_amt+2:
		var column = []
		for j in range(0,cells_amt+2,1):
			column.append([])
		cells.append(column)

func _input(event):
	if event is InputEventMouseMotion:
		amt_moved += event.relative.length()
	if Input.is_action_just_pressed("m1") or event is InputEventMouseMotion and Input.is_action_pressed("m1") and amt_moved > cell_width*pow(2,0.5):
		amt_moved = 0
		add_dot(get_global_mouse_position())
		print($draw_vp.get_child_count())
	if Input.is_action_just_pressed("m2") or event is InputEventMouseMotion and Input.is_action_pressed("m2") and amt_moved > cell_width*pow(2,0.5):
		amt_moved = 0
		clear_dots(get_global_mouse_position(),10)
		print($draw_vp.get_child_count())

func clear_dots(pos,dist):
	var x = clamp(floor(pos.x / cell_width) + 1,dist,cells_amt+1-dist)
	var y = clamp(floor(pos.y / cell_width) + 1,dist,cells_amt+1-dist)
	for i in range(-dist,1+dist,1):
		for j in range(-dist,1+dist,1):
			for k in range(cells[x+i][y+j].size()-1,-1,-1):
				var dot = cells[x+i][y+j][k]
				if (dot.position - pos).length() < cell_width*dist*2:
					dot.queue_free()
					cells[x+i][y+j].erase(dot)
	return Vector2(x,y)

func add_dot(pos):
	var xy_pos = clear_dots(pos,1)
	
	var c = preload("res://dot.tscn").instantiate()
	$draw_vp.add_child(c)
	c.position = pos
	cells[xy_pos.x][xy_pos.y].append(c)
	c.pos = xy_pos
