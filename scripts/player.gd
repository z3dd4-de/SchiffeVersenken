class_name Player extends Node

var p_name: String
var p_type: Globals.Player_type
var p_ships: Array[Ship]
var p_grid: SvGrid
var can_place_ships = false


func _init(_name: String, _type: Globals.Player_type) -> void:
	p_name = _name
	p_type = _type
