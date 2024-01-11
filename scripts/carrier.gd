@tool
class_name Carrier extends Ship

func _init() -> void:
	x = 2
	y = 6
	x_offset = 2
	y_offset = 1
	x_pos_h = 0
	y_pos_h = Globals.PX/2 + 5
	x_pos_v = 0
	y_pos_v = Globals.PX/2
	shots_per_round = 1
	max_hits = set_max_hits()
	ship_type = "Carrier"
	ship_description = "The largest ship with 2*6 cells. But it comes with an advantage: instead of firing it uses the plane to attack the enemy. When this hits a target, automatically 4 neighboring cells are also attacked."
