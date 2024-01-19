class_name Compass extends Node2D

var compass_rotation: int = 0
var target_rotation: int
var step: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	#rotate_needle(0)
	randomize()
	Globals.ShipSelected.connect(ship_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if target_rotation != compass_rotation:
		compass_rotation += step
	else:
		compass_rotation += randi_range(-step, step)


func ship_selected(_type, _descr):
	rotate_needle(Globals.current_ship.angle)


func rotate_needle(angle: int):
	compass_rotation = angle
	$Needle.rotation_degrees = angle
