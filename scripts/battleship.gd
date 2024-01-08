@tool
class_name Battleship extends Ship

func _init() -> void:
	x = 1
	y = 7
	x_offset = 3
	y_offset = 0
	max_hits = set_max_hits()
	ship_type = "Battleship"
	ship_description = "The longest ship (1*7 cells) comes with two shots per round. This might be an advantage in the early game."

