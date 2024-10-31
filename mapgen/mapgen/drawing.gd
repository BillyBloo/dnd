extends Node2D

var last_pos = Vector2.ZERO
var amt_moved = 0.0
var step : float = 1.0
var dot_queue = []

enum states {
	DRAW,
	ERASE,
	IDLE
}
var state : states = states.IDLE

func _ready():
	var s = 0.5
	for i in 25:
		for j in 25:
			var hex = preload("res://hex.tscn").instantiate()
			hex.position.x = (i + fmod(j,2.0)*0.5) * 128 * sqrt(3)/2 * s
			hex.position.y = j * 128 * 0.75 * s
			hex.scale *= s
			add_child(hex)

func _input(event):
	if Input.is_action_just_pressed("grow"):
		Global.change_size(1)
	if Input.is_action_just_pressed("shrink"):
		Global.change_size(-1)
	
	if Input.is_action_just_pressed("m1"):
		last_pos = get_global_mouse_position()
		state = states.DRAW
		dot_queue.append(dot.create(last_pos,1.0))
	if Input.is_action_just_pressed("m2"):
		last_pos = get_global_mouse_position()
		state = states.ERASE
		dot_queue.append(dot.create(last_pos,-1.0))
	if Input.is_action_just_released("m1") or Input.is_action_just_released("m2"):
		state = states.IDLE
	
	if event is InputEventMouseMotion:
		amt_moved += event.relative.length()
	if Input.is_action_just_pressed("m1") or event is InputEventMouseMotion and Input.is_action_pressed("m1") and amt_moved > step:
		amt_moved = 0
		
		interpolate_dots(last_pos, get_global_mouse_position(), 1.0)
		last_pos = get_global_mouse_position()
	if Input.is_action_just_pressed("m2") or event is InputEventMouseMotion and Input.is_action_pressed("m2") and amt_moved > step:
		amt_moved = 0
		
		interpolate_dots(last_pos, get_global_mouse_position(), -1.0)
		last_pos = get_global_mouse_position()

func interpolate_dots(from : Vector2, to : Vector2, erase : float):
	var k : float = (to - from).length() / step
	for i : float in range(int(floor(k))):
		dot_queue.append(dot.create(lerp(from,to,i/k),erase))

func _process(delta):
	for i in range($draw_vp.get_child_count(),0,-1):
		$draw_vp.get_child(i-1).queue_free()
	while dot_queue.size() > 0:
		var queue_dot : dot = dot_queue[0]
		var draw_dot : Sprite2D = preload("res://dot.tscn").instantiate()
		draw_dot.material.set_shader_parameter("a_mult",queue_dot.erase)
		draw_dot.position = queue_dot.pos
		draw_dot.visible = true
		draw_dot.scale *= Global.size / 64.0
		$draw_vp.add_child(draw_dot)
		$draw_vp.set_update_mode(1)
		dot_queue.remove_at(0)
