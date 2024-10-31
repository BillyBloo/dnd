extends Sprite2D

func _process(delta):
	scale = (Global.size / 128.0) * Vector2(1,1)
	position = get_global_mouse_position()
	material.set_shader_parameter("size",Global.size)
