extends Node2D

var start_time
var current_time

var _round = 1
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
	rand = randi_range(0, 1)
	player_first_round()


# Called only on the server.
func start_game():
	# All peers are ready to receive RPCs in this scene.
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta) -> void:
	calc_time()
	set_round_label()


func player_first_round() -> void:
	if rand == 0:
		message_label.text = "You detected the enemy first: \nTry to strike them and use your advantage!"
		$CanvasLayer/Panel/TurnLabel.text = "It's your turn"
	else:
		message_label.text = "You were detected by the enemy and they are attacking you with a first strike."
		disable_shoot()
		$CanvasLayer/Panel/TurnLabel.text = "It's your enemy's turn"
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
