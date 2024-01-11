extends Node2D

@onready var ship_selected_content = $GridContainer/ShipSelectedContent
@onready var description_text = $GridContainer/DescriptionText
@onready var description_label = $GridContainer/DescriptionLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.ShipSelected.connect(show_ship_details)
	show_ship_details("No ship selected", "")
	Globals.DefaultError.connect(show_error_label)
	Globals.DefaultErrorNone.connect(disable_error_label)
	Globals.ShowError.connect(show_error)
	disable_error_label()
	Globals.current_ship = null
	
	# Debug only: TODO remove when ready (is initialized by main_menu or multiplayer lobby)
	if Globals.players.size() == 0:
		Globals.players.append(Player.new("Player 1", Globals.Player_type.PLAYER1))
		Globals.players.append(Player.new("Enemy", Globals.Player_type.ENEMY))
		Globals.players[0].can_place_ships = true
	#else:	# initialized in main_menu
	#	print("Global players (main menu): ", Globals.players.size())


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
	Globals.players[0].can_place_ships = false
	SceneManager.SwitchScene("Game")
