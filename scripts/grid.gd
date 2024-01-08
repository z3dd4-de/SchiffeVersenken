@tool
class_name SvGrid extends Node2D

var line_width: int = 3
var grid_content: Dictionary
var is_valid = false


func _ready() -> void:
	for i in Globals.width:
		for j in Globals.height:
			var cell = Globals.letters[i] + str(Globals.numbers[j])
			grid_content[cell] = "empty"
	#print(grid_content)
	Globals.DropShip.connect(test_ship_location)
	Globals.NotValid.connect(not_valid)


func test_ship_location() -> bool:
	snap_to_grid()
	print("Grid: test location")
	if Globals.current_ship != null:
		print("Ship to be placed: ", Globals.current_ship.ship_type)
		print("Current orientation: ", Globals.current_ship.angle)
	return true


func snap_to_grid() -> void:
	if Globals.current_ship != null and Globals.last_cell != "" and Globals.valid_position:
		if Globals.current_ship.angle == 0 or Globals.current_ship.angle == 180:
			# vertical ship position
			print("Center " + Globals.current_ship.ship_type + " on " + Globals.last_cell)
			#for i in Globals.current_ship.x:
			#	for j in Globals.current_ship.y:


func not_valid() -> void:
	is_valid = false
	Globals.valid_position = is_valid
	print("Not valid")


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


func _input(event) -> void:
	if event is InputEventMouseButton and event.pressed:
		#print("Mouse Click/Unclick at: ", event.position)
		if event.button_index == MOUSE_BUTTON_LEFT:
			highlight_cell()
			var cell_content = test_cell()
			print("Cell content: ", cell_content)
			# place ship on grid


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


func _on_timer_timeout() -> void:
	if $HighlightCell.visible:
		$HighlightCell.visible = false


func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("ship"):
		#print("Ship entered: Area")
		Globals.show_default_error()
		is_valid = false



func _on_area_2d_area_exited(area) -> void:
	if area.is_in_group("ship"):
		#print("Ship left")
		Globals.delete_default_error()
		is_valid = true
