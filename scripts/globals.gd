extends Node

signal ShipSelected
signal ShowError
signal DefaultError
signal DefaultErrorNone
signal DropShip
signal NotValid

const PX = 32
var width = 14
var height = 14

var numbers: Array
var letters: Array

var current_ship: Ship
var valid_position = false
var last_cell = ""

enum Player_type { PLAYER1, PLAYER2, ENEMY }
var players: Array[Player]

var is_multiplayer = false
var server_ip = ""


func _ready() -> void:
	for i in height:
		numbers.append(i + 1)
	for i in width:
		var c = char(65 + i)
		letters.append(c)


func show_ship_details(type: String, descr: String) -> void:
	ShipSelected.emit(type, descr)


func show_error(type: String) -> void:
	ShowError.emit(type)
	valid_position = false


func show_default_error() -> void:
	DefaultError.emit()
	valid_position = false


func delete_default_error() -> void:
	DefaultErrorNone.emit()
	valid_position = true


func drop_ship() -> void:
	DropShip.emit()


func not_valid_grid_position() -> void:
	NotValid.emit()
	valid_position = false


func get_cell_name(x: int, y: int) -> String:
	if x >= 0 and x < width and y >= 0 and y < height:
		return letters[x] + str(numbers[y])
	else:
		return ""

