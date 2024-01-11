@tool
class_name Ship extends Node2D

@export var x: int
@export var y: int
var x_offset: int
var y_offset: int
var x_pos_h: int
var y_pos_h: int
var x_pos_v: int
var y_pos_v: int
var location_array: Dictionary
var shots_per_round: int
var current_player: Player

@export var ship_type: String
@export var ship_description: String

@onready var start_position = global_position

var angle = 0
var max_hits: int
var sunk = false
var hits = 0
var selected = false
var ship_owner

#func _draw() -> void:
#	var half_x = x * Globals.PX / 2
#	var half_y = y * Globals.PX / 2
#	var rect = Rect2(Vector2(-half_x - Globals.PX, -half_y - Globals.PX), Vector2i(2 * half_x + 2 * Globals.PX, 2 * half_y + 2 * Globals.PX))
#	draw_rect(rect, Color.BLUE)

func get_hit() -> void:
	if !sunk:
		hits += 1
		if hits == max_hits:
			sunk = true


func get_max_hits() -> int:
	return max_hits


func set_max_hits() -> int:
	return x * y


func get_ship_type() -> String:
	Globals.show_ship_details(ship_type, ship_description)
	return ship_type


func get_ship_area() -> Vector2i:
	return Vector2i(x + 2, y + 2)


func _on_area_2d_input_event(_viewport, event, _shape_idx) -> void:
	var allowed = Globals.players[0].can_place_ships
	if event is InputEventMouseButton and event.pressed:
		event.position += shift_position()
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				#print("Left Mouse")
				if !selected and Globals.current_ship == null and allowed:
					selected = true
					Globals.current_ship = self
					get_ship_type()
				elif selected and allowed and Globals.current_ship != null:
					if Globals.valid_position:
						Globals.drop_ship()
						selected = false
						Globals.current_ship = null
						Globals.show_ship_details("No ship selected", "")
					else:
						Globals.show_error("Ship cannot be placed on " + Globals.last_cell + ".")
			MOUSE_BUTTON_RIGHT:
				#print("Right Mouse: deselect")
				selected = false
				Globals.current_ship = null
				Globals.show_ship_details("No ship selected", "")
				position = start_position
				rotate_ship(0)
				Globals.delete_default_error()


func shift_position() -> Vector2:
	var shift = Vector2(Globals.PX/2*x, Globals.PX/2*y)
	return shift


func _physics_process(delta) -> void:
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)


func _input(event) -> void:
	if event.is_action_pressed("rotate") and selected:
		angle += 90
		if angle == 360:
			angle = 0
		rotate_ship(angle)


func rotate_ship(ang: int) -> void:
	rotation_degrees = ang


func _on_area_2d_area_entered(area) -> void:
	if area.is_in_group("ship"):
		#print("Ship entered: Ship-")
		Globals.valid_position = false
		Globals.show_error("Ships must not overlap and need to have one line distance to the next ship!")


func _on_area_2d_area_exited(area) -> void:
	if area.is_in_group("ship"):
		#print("Ship left")
		Globals.delete_default_error()
