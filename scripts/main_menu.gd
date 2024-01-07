extends Node2D

@onready var _master = AudioServer.get_bus_index("Master")
@onready var _music = AudioServer.get_bus_index("Music")
@onready var _sfx = AudioServer.get_bus_index("Effects")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/StartGameBackButton.visible = true
	$CanvasLayer/StartGamePanel.visible = true
	$CanvasLayer/StartGameVBoxContainer.visible = true


func _on_settings_button_pressed():
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true


func _on_exit_button_pressed():
	SceneManager.QuitGame()


func _on_settings_back_button_pressed():
	$CanvasLayer/MainVBoxContainer.visible = true
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/SettingsVBoxContainer.visible = false


func _on_audio_button_pressed():
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/AudioBackButton.visible = true
	$CanvasLayer/AudioVBoxContainer.visible = true
	$CanvasLayer/AudioPanel.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = false


func _on_video_button_pressed():
	$CanvasLayer/MainMenuPanel.visible = false
	$CanvasLayer/SettingsBackButton.visible = false
	$CanvasLayer/SettingsVBoxContainer.visible = false
	$CanvasLayer/VideoBackButton.visible = true
	$CanvasLayer/VideoPanel.visible = true
	$CanvasLayer/VideoVBoxContainer.visible = true


func _on_audio_back_button_pressed():
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/MainVBoxContainer.visible = false
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true
	$CanvasLayer/AudioBackButton.visible = false
	$CanvasLayer/AudioVBoxContainer.visible = false
	$CanvasLayer/AudioPanel.visible = false


func _on_video_back_button_pressed():
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/SettingsBackButton.visible = true
	$CanvasLayer/SettingsVBoxContainer.visible = true
	$CanvasLayer/VideoBackButton.visible = false
	$CanvasLayer/VideoPanel.visible = false
	$CanvasLayer/VideoVBoxContainer.visible = false


func _on_fullscreen_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	else:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)


func _on_vsync_check_button_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _on_main_volume_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(_master, linear_to_db(value))


func _on_music_volume_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(_music, linear_to_db(value))


func _on_sfx_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(_sfx, linear_to_db(value))
	$MainMenuSfx.play()


func _on_single_player_button_pressed():
	SceneManager.SwitchScene("AddShips")


func _on_multi_player_button_pressed():
	pass # Replace with function body.


func _on_start_game_back_button_pressed():
	$CanvasLayer/MainVBoxContainer.visible = true
	$CanvasLayer/MainMenuPanel.visible = true
	$CanvasLayer/StartGameBackButton.visible = false
	$CanvasLayer/StartGamePanel.visible = false
	$CanvasLayer/StartGameVBoxContainer.visible = false
