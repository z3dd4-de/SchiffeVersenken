@tool
class_name RescueShip extends Ship

func _init():
	x = 1
	y = 3
	ship_type = "Rescue Ship"
	ship_description = "The rescue ship cannot fire at all, but is small-sized (1*3 cells). You can use it to repair another ship and sacrifice it. So when your repaired the other ship, the rescue ship will be removed from your game and in that round no shot will be fired."
