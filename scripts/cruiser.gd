@tool
extends Ship
class_name Cruiser 

func _init():
	x = 1
	y = 4
	ship_type = "Cruiser"
	ship_description = "The cruiser has no large footprint (1*4 cells), but only has one shot per round. Thus it is a good all-rounder with no big disadvantages, but also no direct advantages. And you have two of them."

func _ready():
	#x = 1
	#y = 4
	#ship_type = "Cruiser"
	#ship_description = "The cruiser has no large footprint (1*4 cells), but only has one shot per round. Thus it is a good all-rounder with no big disadvantages, but also no direct advantages. And you have two of them."
	pass
