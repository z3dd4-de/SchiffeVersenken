@tool
class_name Submarine extends Ship

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
	ship_type = "Submarine"
	ship_description = "The submarine is mid-size (1*4 cells), but the first hit will not be recognized by the enemy. So the first hit will be shown as no hit for the enemy, but then it must surface and can be hit like any other ship. Another advantage is that a torpedo hit randomly hits another neighboring cell as well."
