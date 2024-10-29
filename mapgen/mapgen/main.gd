extends Node2D

var cells_amt = 200
var cell_width = 5.0
var cells = []

func _ready():
	for i in cells_amt+2:
		var column = []
		for j in range(0,cells_amt+2,1):
			column.append([])
		cells.append(column)

func _input(event):
	if Input.is_action_just_pressed("m1") or event is InputEventMouseMotion and Input.is_action_pressed("m1"):
		add_dot(get_global_mouse_position())
	if Input.is_action_just_pressed("m2") or event is InputEventMouseMotion and Input.is_action_pressed("m2"):
		clear_dots(get_global_mouse_position(),1)

func clear_dots(pos,dist):
	var x = clamp(floor(pos.x / cell_width) + 1,dist,cells_amt+1-dist)
	var y = clamp(floor(pos.y / cell_width) + 1,dist,cells_amt+1-dist)
	for i in range(-dist,1+dist,1):
		for j in range(-dist,1+dist,1):
			for k in range(cells[x+i][y+i].size()-1,-1,-1):
				var dot = cells[x+i][y+i][k]
				if (dot.position - pos).length() < cell_width*dist:
					dot.queue_free()
					cells[x+i][y+i].erase(dot)
	return Vector2(x,y)

func add_dot(pos):
	var xy_pos = clear_dots(pos,1)
	
	var c = preload("res://dot.tscn").instantiate()
	$draw_vp.add_child(c)
	c.position = pos
	cells[xy_pos.x][xy_pos.y].append(c)
