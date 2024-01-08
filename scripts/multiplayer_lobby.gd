extends Node2D

@onready var player_status_label = $CanvasLayer/PlayerStatusLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/StatusLabel.text = "Wait for other player to join... [ Server started: " + Globals.server_ip + " ]"
	print(Globals.players)
	for i in Globals.players:
		if i.p_type == Globals.Player_type.PLAYER1:
			$CanvasLayer/LobbyVBoxContainer/Player1Label.text = i.p_name
			player_status_label.text = "Player connected:\n" + i.p_name
			$Timer.start()
	$CanvasLayer/LobbyVBoxContainer/StartGameButton.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func player_connects():
	pass


func _on_timer_timeout():
	player_status_label.visible = false
	$Timer.stop()
