extends Node2D

var start_time
var current_time
var _round = 0
var rand: int

@onready var time_label = $CanvasLayer/Panel/TimeLabel
@onready var message_label = $CanvasLayer/PanelContainer/MessageLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.is_multiplayer:
		Lobby.player_loaded.rpc_id(1)
	start_time = Time.get_unix_time_from_system()
	set_round_label()
	randomize()
	#rand = randi_range(0, 1)
	rand = 0 # TODO: remove after testing. First we test player's first round.
	player_first_round()
	build_players_grid()
	Globals.game_running = true
	Globals.ShipSelected.connect(ship_selected)


# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	pass


func build_players_grid():
	if Globals.current_player != null:
		if Globals.current_player.p_ships.size() > 0:
			for ship in Globals.current_player.p_ships:
				if ship.ship_type != null:
					match ship.ship_type:
						"Battleship":
							var _ship = preload("res://scenes/ships/battleship.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							#print("Battleship game (pos): ", ship.position)
							#print("Battleship game (angle): ", ship.angle)
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship) 
						"Carrier":
							var _ship = preload("res://scenes/ships/carrier.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)
						"Patrol Ship":
							var _ship = preload("res://scenes/ships/patrol.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)
						"Rescue Ship":
							var _ship = preload("res://scenes/ships/rescue_ship.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)
						"Cruiser":
							var _ship = preload("res://scenes/ships/cruiser.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)
						"Destroyer":
							var _ship = preload("res://scenes/ships/destroyer.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)
						"Submarine":
							var _ship = preload("res://scenes/ships/submarine.tscn").instantiate()
							_ship.position = ship.position
							_ship.rotation_degrees = ship.angle
							Globals.current_ship = _ship
							Globals.last_cell = ship.center_field
							snap_to_grid()
							add_child(Globals.current_ship)


func snap_to_grid() -> void:
	print("Stg: last cell: ", Globals.last_cell)
	print("Ship: ", Globals.current_ship)
	if Globals.current_ship != null and Globals.last_cell != "":
		var pos = Globals.get_cell_coordinates(Globals.last_cell)
		print("Stg: Globals.last_cell: ", Globals.last_cell)
		if Globals.current_ship.angle == 0 or Globals.current_ship.angle == 180:
			# vertical ship position
			Globals.current_ship.position = Vector2(pos.x + Globals.current_ship.x_pos_v - 4, pos.y + Globals.current_ship.y_pos_v + 27)
		else:
			# horizontal ship position
			Globals.current_ship.position = Vector2(pos.x + Globals.current_ship.x_pos_h - 4, pos.y + Globals.current_ship.y_pos_h + 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	calc_time()
	set_round_label()


func player_first_round() -> void:
	if rand == 0:
		message_label.text = "You detected the enemy first: \nTry to strike them and use your advantage!"
		$CanvasLayer/Panel/TurnLabel.text = "It's your turn"
		$CanvasLayer/BottomLeftPanel.visible = true
	else:
		message_label.text = "You were detected by the enemy and they are attacking you with a first strike."
		disable_shoot()
		$CanvasLayer/Panel/TurnLabel.text = "It's your enemy's turn"
		$CanvasLayer/BottomLeftPanel.visible = false
	$CanvasLayer/PanelContainer.visible = true
	$MessageTimer.start()


func _on_timer_timeout() -> void:
	$CanvasLayer/PanelContainer.visible = false


func set_round_label() -> void:
	$CanvasLayer/Panel/RoundLabel.text = "Round " + str(_round)


func calc_time() -> void:
	current_time = Time.get_unix_time_from_system()
	var time_played = int(current_time - start_time)
	var hours = time_played / 3600
	time_played = time_played % 3600
	var minutes = time_played / 60
	time_played = time_played % 60
	var seconds = time_played
	var min_str
	if minutes < 10:
		min_str = "0" + str(minutes)
	else:
		min_str = str(minutes)
	var sec_str
	if seconds < 10:
		sec_str = "0" + str(seconds)
	else:
		sec_str = str(seconds)
	var timestring = str(hours) + ":" + min_str + ":" + sec_str 
	time_label.text = "Time: " + timestring


func disable_shoot() -> void:
	$CanvasLayer/PanelContainer2/TextureButton.disabled = true
	$CooldownTimer.start()


func _on_texture_button_pressed() -> void:
	disable_shoot()


func _on_cooldown_timer_timeout() -> void:
	$CanvasLayer/PanelContainer2/TextureButton.disabled = false
	_round += 1
	$CooldownTimer.stop()


func _on_help_button_pressed():
	$CanvasLayer/BottomLeftPanel/HelpLabel.visible = !$CanvasLayer/BottomLeftPanel/HelpLabel.visible


func _on_repair_button_pressed():
	pass # Replace with function body.


func ship_selected(type: String, descr: String):
	$CanvasLayer/BottomLeftPanel/ShipSelectedLabel.text = type
	$CanvasLayer/BottomLeftPanel/SpecialForcesLabel.text = descr
	$CanvasLayer/BottomLeftPanel.visible = true
	


func ship_deselected():
	pass
