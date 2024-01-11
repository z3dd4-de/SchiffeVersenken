@tool
class_name Destroyer extends Ship

func _init() -> void:
	x = 1
	y = 3
	x_offset = 2
	y_offset = 0
	x_pos_h = 0
	y_pos_h = Globals.PX/2 + 5
	x_pos_v = 0
	y_pos_v = Globals.PX/2
	shots_per_round = 1
	max_hits = set_max_hits()
	ship_type = "Destroyer"
	ship_description = "Smaller than the cruiser (1*3 cells), but only one shot per round. Could be helpful in the late game if it survived that long."
