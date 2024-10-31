extends Node

var base = 0.0
var size = 64.0

func change_size(k):
	base += k
	size = 64.0*pow(0.9,base)
