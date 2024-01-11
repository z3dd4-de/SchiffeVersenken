extends Node2D

@onready var _master = AudioServer.get_bus_index("Master")
@onready var _music = AudioServer.get_bus_index("Music")
@onready var _sfx = AudioServer.get_bus_index("Effects")
@onready var player_name_text_edit = $CanvasLayer/MultiplayerVBoxContainer/PlayerNameTextEdit
@onready var client_server_option_button = $CanvasLayer/MultiplayerVBoxContainer/ClientServerOptionButton
@onready var server_ip_text_edit = $CanvasLayer/MultiplayerVBoxContainer/ServerIPTextEdit

var addresses = []


func _ready():
	get_ip_address()
	$CanvasLayer/MultiplayerVBoxContainer/ServerIPTextEdit.text = addresses[0]


func _on_start_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/StartGameBackButton.visible = true
	$CanvasLayer/StartGamePanel.visible = true
	$CanvasLayer/StartGameVBoxContainer.visible = true


func _on_settings_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true


func _on_exit_button_pressed() -> void:
	SceneManager.QuitGame()


func _on_settings_back_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = true
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/SettingsVBoxContainer.visible = false


func _on_audio_button_pressed() -> void:
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/AudioBackButton.visible = true
	$CanvasLayer/AudioVBoxContainer.visible = true
	$CanvasLayer/AudioPanel.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = false


func _on_video_button_pressed() -> void:
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/SettingsVBoxContainer.visible = false
	$CanvasLayer/VideoBackButton.visible = true
	$CanvasLayer/VideoPanel.visible = true
	$CanvasLayer/VideoVBoxContainer.visible = true


func _on_audio_back_button_pressed() -> void:
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true
	$CanvasLayer/AudioBackButton.visible = false
	$CanvasLayer/AudioVBoxContainer.visible = false
	$CanvasLayer/AudioPanel.visible = false


func _on_video_back_button_pressed() -> void:
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true
	$CanvasLayer/VideoBackButton.visible = false
	$CanvasLayer/VideoPanel.visible = false
	$CanvasLayer/VideoVBoxContainer.visible = false


func _on_fullscreen_check_button_toggled(toggled_on) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_check_button_toggled(toggled_on) -> void:
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_vsync_check_button_toggled(toggled_on) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_main_volume_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_master, linear_to_db(value))


func _on_music_volume_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_music, linear_to_db(value))


func _on_sfx_h_slider_value_changed(value) -> void:
	AudioServer.set_bus_volume_db(_sfx, linear_to_db(value))
	$MainMenuSfx.play()


func _on_single_player_button_pressed() -> void:
	Globals.players.append(Player.new("Player 1", Globals.Player_type.PLAYER1))
	Globals.players.append(Player.new("Enemy", Globals.Player_type.ENEMY))
	Globals.players[0].can_place_ships = true
	SceneManager.SwitchScene("AddShips")


func _on_multi_player_button_pressed() -> void:
	$CanvasLayer/MultiplayerPanel.visible = true
	$CanvasLayer/MultiplayerVBoxContainer.visible = true
	$CanvasLayer/MultiplayerGameBackButton.visible = true
	$CanvasLayer/StartGameBackButton.visible = false
	$CanvasLayer/StartGamePanel.visible = false
	$CanvasLayer/StartGameVBoxContainer.visible = false


func _on_start_game_back_button_pressed() -> void:
	$CanvasLayer/MainVBoxContainer.visible = true
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/StartGameBackButton.visible = false
	$CanvasLayer/StartGamePanel.visible = false
	$CanvasLayer/StartGameVBoxContainer.visible = false


func _on_start_network_game_button_pressed() -> void:
	Globals.server_ip = server_ip_text_edit.text
	if client_server_option_button.selected == 0:
		Globals.players.append(Player.new(player_name_text_edit.text, Globals.Player_type.PLAYER1))
	if client_server_option_button.selected == 1:
		Globals.players.append(Player.new(player_name_text_edit.text, Globals.Player_type.PLAYER2))
	Lobby.player_info["name"] = player_name_text_edit
	Lobby.create_game()
	SceneManager.SwitchScene("Lobby")


func _on_multiplayer_game_back_button_pressed() -> void:
	$CanvasLayer/StartGameBackButton.visible = true
	$CanvasLayer/StartGamePanel.visible = true
	$CanvasLayer/StartGameVBoxContainer.visible = true
	$CanvasLayer/MultiplayerPanel.visible = false
	$CanvasLayer/MultiplayerVBoxContainer.visible = false
	$CanvasLayer/MultiplayerGameBackButton.visible = false


func get_ip_address() -> void:
	for ip in IP.get_local_addresses():
		if ip.begins_with("10.") or ip.begins_with("172.16.") or ip.begins_with("192.168."):
			addresses.push_back(ip)
