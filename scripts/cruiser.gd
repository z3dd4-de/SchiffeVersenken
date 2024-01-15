@tool
class_name Cruiser extends Ship

func _init() -> void:
	x = 1
	y = 4
	x_offset = 2
	y_offset = 0
	x_pos_h = Globals.PX/2 + 2
	y_pos_h = Globals.PX/2 + 5
	x_pos_v = 3
	y_pos_v = Globals.PX/2 - 10
	shots_per_round = 1
	max_hits = set_max_hits()
	ship_type = "Cruiser"
	ship_description = "The cruiser has no large footprint (1*4 cells), but only has one shot per round. Thus it is a good all-rounder with no big disadvantages, but also no direct advantages. And you have two of them."

#func _ready() -> void:
	#x = 1
	#y = 4
	#ship_type = "Cruiser"
	#ship_description = "The cruiser has no large footprint (1*4 cells), but only has one shot per round. Thus it is a good all-rounder with no big disadvantages, but also no direct advantages. And you have two of them."
	#pass
