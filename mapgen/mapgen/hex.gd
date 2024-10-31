extends Line2D

func _ready():
	for i in 6:
		add_point(Vector2(0,-64).rotated((float(i)/6.0)*PI*2.0))
