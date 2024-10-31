extends Node

class_name dot

var pos : Vector2
var erase : float

static func create(pos, erase) -> dot:
	var instance = dot.new()
	instance.pos = pos
	instance.erase = erase
	return instance
