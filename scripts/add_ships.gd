@tool
extends Node2D

@onready var ship_selected_content = $GridContainer/ShipSelectedContent
@onready var description_text = $GridContainer/DescriptionText
@onready var description_label = $GridContainer/DescriptionLabel
@onready var grid = $Grid
@onready var start_game_button = $CanvasLayer/MarginContainer/StartGameButton

#ships
@onready var battleship = $Battleship
@onready var carrier = $Carrier
@onready var cruiser = $Cruiser
@onready var cruiser_2 = $Cruiser2
@onready var destroyer = $Destroyer
@onready var patrol = $Patrol
@onready var patrol_2 = $Patrol2
@onready var patrol_3 = $Patrol3
@onready var submarine = $Submarine
@onready var rescue_ship = $RescueShip


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.ShipSelected.connect(show_ship_details)
	show_ship_details("No ship selected", "")
	Globals.DefaultError.connect(show_error_label)
	Globals.DefaultErrorNone.connect(disable_error_label)
	Globals.ShowError.connect(show_error)
	disable_error_label()
	Globals.current_ship = null
	grid.AllShipsPlaced.connect(enable_start_button)
	grid.NotAllShipsPlaced.connect(disable_start_button)
	
	# Debug only: TODO remove when ready (is initialized by main_menu or multiplayer lobby)
	if Globals.players.size() == 0:
		Globals.players.append(Player.new("Player 1", Globals.Player_type.PLAYER1))
		Globals.players.append(Player.new("Enemy", Globals.Player_type.ENEMY))
		Globals.players[0].can_place_ships = true
		Globals.current_player = Globals.players[0]
	#else:	# initialized in main_menu
	#	print("Global players (main menu): ", Globals.players.size())
	#if !Globals.is_multiplayer:
	#	print("Current Player: ", Globals.current_player.p_name)


func add_ships():
	battleship.ship_owner = Globals.current_player
	#print("Battleship add ship (pos): ", battleship.position)
	#print("Battleship add ship (angle): ", battleship.angle)
	#print("Battleship add ship (last cell): ", battleship.center_field)
	Globals.current_player.p_ships.append(battleship.duplicate())
	Globals.current_player.p_ships[0].angle = battleship.angle
	Globals.current_player.p_ships[0].center_field = battleship.center_field
	carrier.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(carrier.duplicate())
	Globals.current_player.p_ships[1].angle = carrier.angle
	Globals.current_player.p_ships[1].center_field = carrier.center_field
	cruiser.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(cruiser.duplicate())
	Globals.current_player.p_ships[2].angle = cruiser.angle
	Globals.current_player.p_ships[2].center_field = cruiser.center_field
	cruiser_2.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(cruiser_2.duplicate())
	Globals.current_player.p_ships[3].angle = cruiser_2.angle
	Globals.current_player.p_ships[3].center_field = cruiser_2.center_field
	destroyer.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(destroyer.duplicate())
	Globals.current_player.p_ships[4].angle = destroyer.angle
	Globals.current_player.p_ships[4].center_field = destroyer.center_field
	patrol.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(patrol.duplicate())
	Globals.current_player.p_ships[5].angle = patrol.angle
	Globals.current_player.p_ships[5].center_field = patrol.center_field
	patrol_2.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(patrol_2.duplicate())
	Globals.current_player.p_ships[6].angle = patrol_2.angle
	Globals.current_player.p_ships[6].center_field = patrol_2.center_field
	patrol_3.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(patrol_3.duplicate())
	Globals.current_player.p_ships[7].angle = patrol_3.angle
	Globals.current_player.p_ships[7].center_field = patrol_3.center_field
	submarine.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(submarine.duplicate())
	Globals.current_player.p_ships[8].angle = submarine.angle
	Globals.current_player.p_ships[8].center_field = submarine.center_field
	rescue_ship.ship_owner = Globals.current_player
	Globals.current_player.p_ships.append(rescue_ship.duplicate())
	Globals.current_player.p_ships[9].angle = rescue_ship.angle
	Globals.current_player.p_ships[9].center_field = rescue_ship.center_field


func disable_start_button():
	start_game_button.disabled = true


func enable_start_button():
	start_game_button.disabled = false


func show_ship_details(type: String, descr: String) -> void:
	ship_selected_content.text = type
	description_text.text = descr
	if descr == "":
		description_label.visible = false
	else: 
		description_label.visible = true


func show_error(error: String) -> void:
	$ErrorLabel.text = error
	$ErrorLabel.visible = true
	Globals.not_valid_grid_position()


func show_error_label() -> void:
	$ErrorLabel.text = "Ship cannot be placed outside the grid!"
	$ErrorLabel.visible = true
	Globals.not_valid_grid_position()


func disable_error_label() -> void:
	$ErrorLabel.visible = false


func _on_button_pressed() -> void:
	$HelpLabel.visible = !$HelpLabel.visible


func _on_start_game_button_pressed() -> void:
	Globals.current_player.can_place_ships = false
	#TODO add ships from grid to player's grid_content
	add_ships()
	Globals.players[0] = Globals.current_player
	SceneManager.SwitchScene("Game")
