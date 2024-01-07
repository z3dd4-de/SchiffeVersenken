@tool
class_name PatrolShip extends Ship

func _init():
	x = 1
	y = 2
	ship_type = "Patrol Ship"
	ship_description = "This ship is the smallest of all ships (1*2 cells) and you have three of them. So they are difficult to hit. But this comes with a big disadvantage: only every second shot might hit (random). Normally only relevant in the late game."
