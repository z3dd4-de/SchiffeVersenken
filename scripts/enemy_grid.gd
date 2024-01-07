@tool
extends Node2D

var line_width: int = 3
var grid_content: Dictionary
var is_valid = false
var pos: Vector2i
var ships: Array[Ship]
var orientation = [0, 90, 180, 270]

const _carrier = preload("res://scenes/carrier.tscn")
const _battleship = preload("res://scenes/battleship.tscn")
const _cruiser = preload("res://scenes/cruiser.tscn")
const _destroyer = preload("res://scenes/destroyer.tscn")
const _rescue = preload("res://scenes/rescue_ship.tscn")
const _patrol = preload("res://scenes/patrol.tscn")
const _submarine = preload("res://scenes/submarine.tscn")


func _ready() -> void:
	for i in Globals.width:
		for j in Globals.height:
			var cell = Globals.letters[i] + str(Globals.numbers[j])
			grid_content[cell] = "empty"
	#print(grid_content)
	
	ships.append(Carrier.new())
	ships.append(Battleship.new())
	ships.append(Cruiser.new())
	ships.append(Cruiser.new())
	ships.append(Submarine.new())
	ships.append(Destroyer.new())
	ships.append(RescueShip.new())
	ships.append(PatrolShip.new())
	ships.append(PatrolShip.new())
	ships.append(PatrolShip.new())
	randomize()
	place_ships()


func place_ships():
	for i in 10:
		var ran = get_random_orientation()
		var x = 0
		var y = 0
		var pos
		#print(ran)
		#print(ships[i].ship_type)
		ships[i].angle = ran
		if i == 0: # Carrier
			if ran == 0 or ran == 180:
				x = randi_range(1, Globals.width - (ships[i].x - 1))
				y = randi_range(3, Globals.height - (ships[i].y - 1))
			else:
				x = randi_range(3, Globals.width - (ships[i].y - 1))
				y = randi_range(1, Globals.height - (ships[i].x - 1))
			print(ships[i].ship_type + " on " + Globals.get_cell_name(x, y))
			var _ship = preload("res://scenes/carrier.tscn").instantiate()
			_ship.position = Vector2(x * Globals.PX, y * Globals.PX)
			_ship.rotation_degrees = ran
			add_child(_ship)
			# fill grid_content missing TODO
			if ran == 0 or ran == 180:
				for k in range(x - ships[i].x, x + ships[i].x):
					for l in range(y - 4, y + 4):
						if (x >= 0 and y >= 0 and x < Globals.width and y < Globals.height):
							var cont 
							if k == x - 2 or k == x + 1 or l == y - 4 or l == y + 3:
								cont = "reserved"
							else:
								cont = ships[i].ship_type
							if Globals.get_cell_name(k, l) != "":
								print(Globals.get_cell_name(k, l) + "; " + cont)
								grid_content[Globals.get_cell_name(k, l)] = cont
			else:
				for k in range(x - 4, x + 4):
					for l in range(y - 2, y + 1):
						if (x >= 0 and y >= 0 and x < Globals.width and y < Globals.height):
							var cont 
							if k == x - 4 or k == x + 3 or l == y - 2 or l == y + 2:
								cont = "reserved"
							else:
								cont = ships[i].ship_type
							print(Globals.get_cell_name(k, l) + "; " + cont)
							grid_content[Globals.get_cell_name(k, l)] = cont
		elif i == 1: # Battleship
			Globals.valid_position = false
			#while(!Globals.valid_position):
			#	if ran == 0 or ran == 180:
			#		x = randi_range(0, Globals.width)
			#		y = randi_range(3, Globals.height - 4)
			#	else:
			#		x = randi_range(3, Globals.width - 4)
			#		y = randi_range(0, Globals.height - 1)
			#	print(ships[i].ship_type + " on " + Globals.get_cell_name(x, y))
				
			#	Globals.valid_position = true
			pos = get_valid_position(ships[i])
			var _ship = preload("res://scenes/battleship.tscn").instantiate()
			_ship.position = Vector2(pos.x * Globals.PX + Globals.PX/2, pos.y * Globals.PX + Globals.PX/2)
			print("Ship position: ", _ship.position)
			_ship.rotation_degrees = ships[i].angle
			add_child(_ship)
		
	print(grid_content)


func get_random_orientation() -> int:
	orientation.shuffle()
	return orientation.front()


func get_valid_position(ship: Ship): 	# -> Vector2i
	var ret = false
	var x = 0
	var y = 0
	
	while(!ret):
		if ship.angle == 0 or ship.angle == 180:
			x = randi_range(ship.x_offset, Globals.width - (ship.x_offset - 1))
			y = randi_range(3, Globals.height - (ship.y - 1))
		else:
			x = randi_range(ship.x_offset, Globals.width - (ship.x_offset - 1))
			y = randi_range(ship.y_offset, Globals.height - (ship.y_offset - 1))
		print(ship.ship_type + " on " + Globals.get_cell_name(x, y))
		if Globals.get_cell_name(x, y) != "":
			var test = get_cell_content(Globals.get_cell_name(x, y))
			if test == "empty":
				if ship.angle == 0 or ship.angle == 180:
					for k in range(x - ship.x_offset, x + ship.x_offset):
						for l in range(y - 1, y + 1):
							if k >= 0 and l >= 0 and k < Globals.width and l < Globals.height:
								test = get_cell_content(Globals.get_cell_name(k, l))
								if test != "empty":
									ret = false
								
					ret = true
				return Vector2i(x, y)
		else:
			ret = false


func get_cell_content(cell_name: String) -> String:
	return grid_content[cell_name]


func _draw() -> void:
	var x = 0
	var y = 0
	var default_font = ThemeDB.fallback_font
	var rect = Rect2(Vector2(x, y), Vector2i(Globals.width * Globals.PX, Globals.height * Globals.PX))
	draw_rect(rect, Color.BLUE)
	for i in Globals.height + 1:
		draw_line(Vector2i(x, y), Vector2i(Globals.width * Globals.PX, y), Color.BLACK, line_width)
		y += Globals.PX
	y = 0
	var cnt = 0
	for i in Globals.numbers:
		draw_string(default_font, Vector2((Globals.width + 1) * Globals.PX - 25, y + i * Globals.PX - 10), str(i), HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color.BLACK)
	for i in Globals.letters:
		draw_string(default_font, Vector2(x + cnt * Globals.PX + 8, (Globals.height + 1) * Globals.PX - 10), i, HORIZONTAL_ALIGNMENT_LEFT, -1, 24, Color.BLACK)
		cnt += 1
	for i in Globals.width + 1:
		draw_line(Vector2i(x, y), Vector2i(i * Globals.PX, Globals.height * Globals.PX), Color.BLACK, line_width)
		x += Globals.PX


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		#print("Mouse Click/Unclick at: ", event.position)
		if event.button_index == MOUSE_BUTTON_LEFT:
			highlight_cell()
			var cell_content = test_cell()
			print("Cell content: ", cell_content)


func test_cell() -> String:
	var x = int(self.get_local_mouse_position().x) / Globals.PX
	var y = int(self.get_local_mouse_position().y) / Globals.PX
	if x >= 0 and x < Globals.width and y >= 0 and y < Globals.height:
		return grid_content[Globals.get_cell_name(x, y)]
	else:
		return ""


func highlight_cell() -> void:
	var x = int(self.get_local_mouse_position().x) / Globals.PX
	var y = int(self.get_local_mouse_position().y) / Globals.PX
	if x >= 0 and x < Globals.width and y >= 0 and y < Globals.height:
		$HighlightCell.position.x = x * Globals.PX
		$HighlightCell.position.y = y * Globals.PX
		$HighlightCell.visible = true
		print("Cell: %s%d" % [Globals.letters[x], Globals.numbers[y]])
		Globals.last_cell = Globals.get_cell_name(x, y)
		$Timer.start()


func _on_timer_timeout():
	if $HighlightCell.visible:
		$HighlightCell.visible = false


func _on_button_pressed():
	place_ships()
