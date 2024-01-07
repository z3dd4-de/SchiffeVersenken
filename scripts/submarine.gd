@tool
class_name Submarine extends Ship

func _init():
	x = 1
	y = 4
	ship_type = "Submarine"
	ship_description = "The submarine is mid-size (1*4 cells), but the first hit will not be recognized by the enemy. So the first hit will be shown as no hit for the enemy, but then it must surface and can be hit like any other ship. Another advantage is that a torpedo hit randomly hits another neighboring cell as well."
